function [tstat, xbar, std_dev, cohensd] = mvtstat( data, threeD, nansaszeros )
% MVTSTAT( data, threeD, nansaszeros ) computes the multivariate t-statistic.
%--------------------------------------------------------------------------
% ARGUMENTS
% data          An nsubj by nvox matrix with the data. Can also take in an 
%               nsubj by Dim matrix with the data but not fixed the output
%               for this yet, the output is then [1, 91, 109, 91] not
%               [91,109,91].
% threeD        0/1, whether to return a 3D image or not. Default = 0.
%--------------------------------------------------------------------------
% OUTPUT
% tstat         the one sample t-statistic at each voxel.
%--------------------------------------------------------------------------
% EXAMPLES
% noise = noisegen([91,109,91], 20, 6, 1);
% tstat = mvtstat(noise);
%
% nsubj = 20;
% noise = noisegen([91,109,91], nsubj, 6, 3);
% tstat = mvtstat(noise);
% vox = 150;
% noise_at_vox = noise(:, vox);
% muuuu = mean(noise_at_vox)
% sigmatilde = std(noise_at_vox)
% sqrt(nsubj)*mu/sigmatilde
% tstat(vox)
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 2
    threeD = 0;
end
if nargin < 3
    nansaszeros = 0;
end

sD = size(data);
% Error checking
if length(sD) > 2
    if sD(end) ~= 91
        warning('It''s possible that your array is of the wrong shape as it isn''t in MNI space')
    end
end
nsubj = sD(1);

xbar = mean(data);
sq_xbar = mean(data.^2);
    
est_var = (nsubj/(nsubj-1))*(sq_xbar - (xbar.^2));
std_dev = sqrt(est_var);

if threeD
    stdsize = [91,109,91];
    xbar = reshape(xbar, stdsize);
    std_dev = reshape(std_dev, stdsize);
else
    xbar = xbar(:);
    std_dev = std_dev(:);
end

tstat = sqrt(nsubj)*xbar./std_dev;
cohensd = xbar./std_dev;

if nansaszeros
    tstat = nan2zero(tstat);
    cohensd = nan2zero(cohensd);
end

end

