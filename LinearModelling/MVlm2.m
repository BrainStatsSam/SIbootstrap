function [ coeffs, std_residuals, fitted, R2 ] = MVlm2( var, data )
% MVlm2( var, data ) fits a linear model at each voxel using fitlm 
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
% R2            a 1 by nvox vector with the R2 value, for including the 
%               variable or not, at each voxel.
%--------------------------------------------------------------------------
% EXAMPLES
% 
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
R2 = zeros(1, nvox);


X = [ones(nsubj,1), var];
coeff_mate = inv(transpose(X)*X)*transpose(X);
P = X*coeff_mate;
oneminusH = 1 - diag(P);

fitted = zeros(2, nvox);
for v = 1:nvox
    coeffs(:, v) = coeff_mate*data(:,v);
    fitted(:,v) = X*coeffs(:,v);
end

std_residuals = (data - fitted)./sqrt(oneminusH);


for v = 1:nvox
    %Should probably replace this stuff below and compute things myself in
    %order to make it faster.
    voxfit = fitlm(var, data(:,v));
    coeffs(:, v) = voxfit.Coefficients.Estimate;
    std_residuals(:,v) = voxfit.Residuals.Standardized;
    fitted(:,v) = voxfit.Fitted;
    R2(v) = voxfit.Rsquared.Ordinary;
end


end