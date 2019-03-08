function [ coeffs, sigma2, std_residuals, fitted, R2, tvec, residuals ] = MVlm( var, data )
% MVlm( var, data ) fits a linear model at each voxel using fitlm 
%   and gives out the result. 
%--------------------------------------------------------------------------
% ARGUMENTS
%%% Do you really mean a column vector? Var would seem to be any dim
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
% std_residuals     The standardized residuals eg Y-Xbetahat. Except that
%               they're not since you need to divide them by sigma to get
%               the standardized residuals. See Davison p 259.
% fitted        the fitted value: Yhat = Xbetahat.
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
% noise = noisegen(160, nsubj, 6, 3);
% 
% for I = 1:nsubj
%     data(I,:) = intercept + beta*x(I) + noise(I,:);
% end
% 
% [ coeffs, ~, ~, ~, R2 ] = MVlm( x, data );
% plot(R2)
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
if nsubj ~= svar(1)
    error('the number of subjects in the var and data arrays is not the same')
end

X = [ones(nsubj,1), var];
XtXinv = inv(transpose(X)*X);
% coeff_mate = XtXinv*transpose(X);
pX = pinv(X); %%% Equiv to (X'X)^{-1}X' but more numerical stable
P = X*pX;
oneminusH = 1 - diag(P);

coeffs = pX*data;
fitted = X*coeffs;

residuals = data - fitted;
% std_residuals = bsxfun(@ldivide,sqrt(oneminusH),residuals); %%% This is better
std_residuals = residuals./repmat(sqrt(oneminusH),1,nvox);

sigma2 = (1/(nsubj-nvar))*sum(residuals.^2);

tvec = coeffs(2,:)./sqrt(sigma2*XtXinv(2,2));
% warning('This only works if you are regressing against one variable and an intercept')

%%% Why do you need the repmat here?
Fstat = tvec.^2;
R2 = F2R(Fstat, repmat(nsubj,nvox,1)', nvar);

end