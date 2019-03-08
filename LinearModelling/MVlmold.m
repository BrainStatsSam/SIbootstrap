function [ coeffs, sigma2, std_residuals, fitted, R2 ] = MVlmold( var, data )
% MVlm( var, data ) fits a linear model at each voxel using fitlm 
%   and gives out the result.
%--------------------------------------------------------------------------
% ARGUMENTS
% var       An nsubj by 1 column vector with the varaible (nsubj is the 
%           number of subjects).
% data      An nsubj by nvox array where nvox is the number of voxels. Note
%           that for memory reasons we probably shouldn't take nsubj to be
%           more than 100 otherwise things will likely crash.
% include_intercept     0/1. 1 includes an intercept term, 0 doesn't.
%                       Default is to include one.
%--------------------------------------------------------------------------
% OUTPUT
% coeffs        an ncoeff by nvox vector with the linear model estimate for the 
%               intercept at each voxel. Where ncoeff is the number of
%               coefficients in the linear model.
% sigma         A 1 by nvox vector with the estimate of the population
%               sigma^2 at each voxel.
% std_residuals     The standardized residuals eg Y-Xbetahat.
% fitted        the fitted value: Xbetahat.
% R2            a 1 by nvox vector with the R2 value, for including the 
%               variable or not, at each voxel.
%--------------------------------------------------------------------------
% EXAMPLES
% nsubj = 20;
% x = randn(nsubj,1);
% 
% intercept = ones(1,160);
% beta = [zeros(1,40),2*ones(1,80), zeros(1,40)];
% 
% data = zeros(nsubj, 160);
% noise = noisegen(160, nsubj, 6);
% 
% for I = 1:nsubj
%     data(I,:) = intercept + beta*x(I) + noise(I,:);
% end
% 
% [ coeffs, ~, ~, ~, R2 ] = MVlm( x, data );
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport
%--------------------------------------------------------------------------
if nargin < 3
    include_intercept = 1;
end

svar = size(var);
sdata = size(data);
nsubj = sdata(1);
nvox = sdata(2);

nvar = 2; %Intercept and the variable need to potentially change this to make it more general.

if svar(2) ~= 1
    error('var must be a column vector')
end
if nsubj ~= svar(1);
    error('the number of subjects in the var and data arrays is not the same')
end

coeffs = zeros(nvar,nvox);
fitted = zeros(nsubj, nvox);

X = [ones(nsubj,1), var];
XtXinv = inv(transpose(X)*X);
coeff_mate = XtXinv*transpose(X);
P = X*coeff_mate;
oneminusH = 1 - diag(P);

for v = 1:nvox
    coeffs(:, v) = coeff_mate*data(:,v);
    fitted(:,v) = X*coeffs(:,v);
end

residuals = data - fitted;
std_residuals = residuals./repmat(sqrt(oneminusH),1,nvox); %Could do this bit with a for loop.


sigma2 = (1/(nsubj-1))*sum(residuals.^2,1);

tvec = coeffs(2,:)./sqrt(sigma2*XtXinv(2,2));
% warning('This only works if you are regressing against one variable and an intercept'

R2 = F2R(tvec.^2, repmat(nsubj,nvox,1)', nvar);

end