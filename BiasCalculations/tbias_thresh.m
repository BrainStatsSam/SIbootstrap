function [ mos_est, naiveest, trueval, top_lm_indices ] = tbias_thresh( local, B, data, mask, threshold, true_mos, smooth_var )
% tbias takes in data and estimates the bias at the local maxima of the 
% t-statistic via bootstrapping, working with reshaped data.
%--------------------------------------------------------------------------
% ARGUMENTS
% local     0/1. 1 means that the value at the maximum of the bootstrap is
%           compared to the value of the mean at that voxel. 0 means it is 
%           compared to the maximum of the mean. DEFAULT: 1
% top       a number less than the total number of voxels in each image
%           that denotes the number of top values to consider. Eg top = 1,
%           means that the bias is just calculated for the maximum. top = 2
%           means that the bias is calculated for the top two values etc.
%           DEFAULT: 20
% B         the number of bootstrap iterations to do. DEFAULT: 50
% data      a 2d matrix that is the number of subjects by the number of
%           voxels.
% true_mos  a 3d array giving the true mos (mean over std-deviation) at each voxel.
% smooth_var 0/1. Under 1 the variance estimate is smoothed additionally.
% mask      the mask over which to do the inference. Usually we take it to
%           be intersection of the subject masks. If this is not specified
%           the MNI mask of the brain is used.
%--------------------------------------------------------------------------
% OUTPUT
% meanest       a 1xtop vector of the estimates of the mean for the top top
%               values.
% naiveest      the estimate of the mean using the naive method which
%               doesn't correct for the bias.
% trueatlocs    the true values at the locations of the local maxima of the
%               estimated mean.
% top_lm_indicies the indicies of the local maxima of the estimated mean.
%
% OLD OUTPUT:
% diff2truemean a 1xtop vector giving the differences to the true mean
%               for the top values.
% diffwas       a 1xtop vector giving the values of what the biases were of
%               the empirical mean relative to the true mean.
%--------------------------------------------------------------------------
% EXAMPLES
% Default implementation (uses the first 20 subjects):
% [ meanest, diff2truemean ] = tbias();
%
% Using the global option:
% data = zeros([20, 91*109*91]);
% for I = 1:20
%     img = readimg(I);
%     data(I,:) = img(:);
% end 
% [ meanest, naiveest, trueval, top_lm_indices ] = tbias(0, 20, 10, data);
% diff2truemean
%
% %Giving in data:
% data = getdata(1:20);
% [ meanest, naiveest, trueval, top_lm_indices ] = tbias(1, 20, 10, data)
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport
if nargin < 1
    local = 1;
end
if nargin < 2
    B = 10;
end
if nargin < 3
    global TYPE
    if strcmp(TYPE,'jala')
        data = zeros([20, 91*109*91]);
        for I = 1:20
            img = readimg(I);
            data(I,:) = img(:);
        end
    else
        data = datagen(4,20); %So that different data is used each time.
    end
    fprintf('Done with data generation\n')
end
if nargin < 4
    mask = imgload('MNImask');
end
if nargin < 5
    threshold = NaN;
end
if nargin < 6
    smooth_var = 0;
end
if nargin < 7
    true_mos = NaN;
end

s = size(true_mos);
if s(1) ~= 1
    error('The true value vector must be a row vector')
end

[nSubj, ~] = size(data);
[~, ~, est_mos_vec] = meanmos(data, smooth_var);

if isnan(threshold)
    fwhm_est = est_smooth(reshape(data', [91,109,91, nSubj]));
    resel_vec = spm_resels_vol(mask, fwhm_est)';
    threshold = spm_uc( 0.05, [1,(nSubj-1)], 'T', resel_vec, 1 );
end

mask_of_greater_than_threshold = (sqrt(nSubj)*est_mos_vec > threshold);
mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;

% mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;
% top = numOfConComps(mask_of_greater_than_threshold, 0.5, 3);
% top_lm_indices = lmindices(est_mos_vec,top, mask);

[top_lm_indices, top] = lmindices(est_mos_vec, Inf, mask_of_greater_than_threshold);

if top == 0
    mos_est = NaN;
    naiveest = NaN;
    trueval = NaN;
    return
end

bias = 0;
for b = 1:B
    b
    sample_index = randsample(nSubj,nSubj,1);
    temp_data = data(sample_index, :);
    
%     mean_map = mean(temp_data,1);
%     sq_mean_map = mean(temp_data.^2);
%     var_map = (nSubj/(nSubj-1))*(sq_mean_map - (mean_map.^2));
%     sd_map = sqrt(var_map);
%     mos_map = mean_map./sd_map;
%     t_map = sqrt(nSubj)*mean_map./std_map;

    [~, ~, mos_map] = meanmos(temp_data, smooth_var);
    
    lm_indices = lmindices(mos_map, top, mask);
    if local == 1
        bias = bias + mos_map(lm_indices) - est_mos_vec(lm_indices);
    else
        bias = bias + mos_map(lm_indices) - est_mos_vec(top_lm_indices);
    end
end

bias = bias/B;
mos_est = est_mos_vec(top_lm_indices) - bias;

naiveest = est_mos_vec(top_lm_indices);
warning('You need to divide by the nctcorrection')
% naiveest = mos_est_vec(top_lm_indices)/nctcorrection(nSubj); %Correction for the bias in t.

if isnan(true_mos);
    trueval = NaN;
else
    trueval = true_mos(top_lm_indices);
end

end

