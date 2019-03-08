function out = MVlm_multivar( X, data, c, use_inter )
% MVlm( var, data ) fits a linear model at each voxel.
%--------------------------------------------------------------------------
% ARGUMENTS
%%% Do you really mean a column vector? Var would seem to be any dim
% X         A design matrix, without an intercept.
% data      An nsubj by nvox array where nvox is the number of voxels. Note
%           that for memory reasons we probably shouldn't take nsubj to be
%           more than 100 otherwise things will likely crash.
% c         A contrast vector.
% include_intercept     0/1. 1 includes an intercept term, 0 doesn't.
%                       Default is to include one.
%--------------------------------------------------------------------------
% OUTPUT
% out.coeffs        an ncoeff by nvox vector, where ncoeff is the number of
%               coefficients in the linear model. This includes an
%               intercept term if that is what has been chosen.
% out.sigma2         A 1 by nvox vector with the estimate of the population
%               sigma^2 at each voxel.
% out.residuals     The residuals Y-Xbetahat.
% out.std_residuals      The standardized residuals 
% out.fitted        the out.fitted value: Yhat = Xbetahat.
% out.tstat         the t-stat.
% out.R2            a 1 by nvox vector with the out.R2 value, for including the
%               variable or not, at each voxel.
%--------------------------------------------------------------------------
% EXAMPLES
% nsubj = 10000;
% x = randn(nsubj,1);
% z = randn(nsubj, 1);
%
% intercept = ones(1,160);
% beta = [zeros(1,40),2*ones(1,80), zeros(1,40)];
% gamma = 2*ones(1,160);
%
% data = zeros(nsubj, 160);
% noise = noisegen(160, nsubj, 6, 3);
%
% for I = 1:nsubj
%     data(I,:) = intercept + beta*x(I) + gamma*z(I) + noise(I,:);
% end
%
% [ out.coeffs, ~, ~, ~, out.R2 ] = MVlm_multivar( [x, z], data, [0,0,1] );
% plot(out.R2)
% %out.R2 should on average be 0.8:
% nsubj = 100000;
% x = randn(nsubj,1);
% z = randn(nsubj, 1);
% e = randn(nsubj,1);
% Y = 1 + 2*x + 2*z + e;
% fit = myfit([x, z], Y)
% fit.partialout.R2(3)
% fit.betahat
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport
%--------------------------------------------------------------------------
if nargin < 3
    c = NaN;
end
if nargin < 4
    use_inter = 1;
end

sdata = size(data);
nsubj = sdata(1);
nvox = sdata(2);
sX = size(X);
nvar = sX(2);
sc = size(c); %Size of the contrast vector.


if sX(1) < nvar
    error('X has more covariates than there are subjects. (Not set up for this yet).')
end
if nsubj ~= sX(1)
    error('the number of subjects in the var and data arrays is not the same')
end

if sc(1) < sc(2)
    c = c';
end
if sc(1) ~= 1
    error('c must be a contrast vector');
end

if use_inter == 1
    X = [ones(nsubj,1), X];
    nvar = nvar + 1;
end

out.XtXinv = inv(transpose(X)*X); %Used to derive the SE.
% coeff_mate = out.XtXinv*transpose(X);
pX = pinv(X); %%% Equiv to (X'X)^{-1}X' but more numerical stable
P = X*pX;
oneminusH = 1 - diag(P);

out.coeffs = pX*data;
out.fitted = X*out.coeffs;

out.residuals = data - out.fitted;
% repmat(sqrt(oneminusH),1,nvox)
% size(repmat(sqrt(oneminusH),1,nvox))
% out.std_out.residuals = bsxfun(@ldivide,sqrt(oneminusH),out.residuals); %%% This is better
out.std_residuals = out.residuals./repmat(sqrt(oneminusH),1,nvox);

out.sigma2 = (1/(nsubj-nvar))*sum(out.residuals.^2,1); %This is a vector with a value for each voxel.

if ~isnan(c)
    tc = transpose(c);
    % size(out.coeffs)
    out.tstat = tc*out.coeffs./(sqrt(out.sigma2'*(tc*out.XtXinv*c))');
    
    %%% Why do you need the repmat here?
    out.Fstat = out.tstat.^2;
    [out.R2,out.f2] = F2R(out.Fstat, repmat(nsubj,nvox,1)', nvar, nvar - 1);
    %Note p_0 = nvar - 1, as we're testing a single contrast here!
end


end