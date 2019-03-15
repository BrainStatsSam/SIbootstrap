function [ CD_est, naiveest, trueval, top_lm_indices ] = tbias_thresh( local, B, data, true_CD, mask, threshold )
% TBIAS_THRESH( local, B, data, true_CD, mask, threshold ) takes in data 
% and estimates the bias in Cohen's d at the local maxima of the t-statistic 
% via  bootstrapping.
%--------------------------------------------------------------------------
% local     0/1. 1 means that the value at the maximum of the bootstrap is
%           compared to the value of the mean at that voxel. 0 means it is 
%           compared to the maximum of the mean. DEFAULT: 1
% B         the number of bootstrap iterations to do. DEFAULT: 1000.
% X         the design matrix.
% data      a 2d matrix that is the number of subjects by the number of
%           voxels.
% true_CD   a 3d array giving the true Cohen's d at each voxel.
% mask      the mask over which to do the inference. Usually we take it to
%           be intersection of the subject masks. If this is not specified
%           the mask is just taken to be 1 everywhere.
% threshold the threshold to use, RFT is implemented if this is omitted.
%--------------------------------------------------------------------------
% OUTPUT
% CD_est       corrected Cohen's d estimates at significant local maxima 
%              of the t-statistic.
% naiveest      circular Cohen's d estimates at significant local maxima of 
%               the t-statistic.
% top_lm_indices the indices of the local maxima of the t-statistic.
%               above the threshold
% trueval       true mean values at significant local maxima of the 
%               t-statistic.
%--------------------------------------------------------------------------
% EXAMPLES
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport
if nargin < 1
    local = 1;
end
if nargin < 2
    B = 1000;
end
if nargin < 4
    true_CD = NaN;
end
if nargin < 6
    threshold = NaN;
end


s = size(true_CD);
if s(1) ~= 1
    error('The true value vector must be a row vector')
end

[nSubj, nVox] = size(data);
if nargin < 5
    mask = ones(1, nVox);
end
[~, ~, est_CD_vec] = meanmos(data);

if isnan(threshold)
    fwhm_est = est_smooth(reshape(data', [91,109,91, nSubj]));
    resel_vec = spm_resels_vol(mask, fwhm_est)';
    threshold = spm_uc( 0.05, [1,(nSubj-1)], 'T', resel_vec, 1 );
end

mask_of_greater_than_threshold = (sqrt(nSubj)*est_CD_vec > threshold);
mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;

% mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;
% top = numOfConComps(mask_of_greater_than_threshold, 0.5, 3);
% top_lm_indices = lmindices(est_mos_vec,top, mask);

[top_lm_indices, top] = lmindices(est_CD_vec, Inf, mask_of_greater_than_threshold);

if top == 0
    CD_est = NaN;
    naiveest = NaN;
    trueval = NaN;
    return
end

bias = 0;
for b = 1:B
    b
    sample_index = randsample(nSubj,nSubj,1);
    temp_data = data(sample_index, :);

    [~, ~, CD_map] = meanmos(temp_data);
    
    lm_indices = lmindices(CD_map, top, mask);
    if local == 1
        bias = bias + CD_map(lm_indices) - est_CD_vec(lm_indices);
    else
        bias = bias + CD_map(lm_indices) - est_CD_vec(top_lm_indices);
    end
end

bias = bias/B;
CD_est = est_CD_vec(top_lm_indices) - bias;
CD_est = CD_est/nctcorrection(nSubj);

naiveest = est_CD_vec(top_lm_indices)/nctcorrection(nSubj);

if isnan(true_CD);
    trueval = NaN;
else
    trueval = true_CD(top_lm_indices);
end

end

