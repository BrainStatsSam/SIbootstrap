function [ meanest, naiveest, trueval, top_lm_indices ] = t4lmbias( local, B, data, mask, threshold, true_mean ) 
% LMBIAS takes in data and estimates the bias at the local maxima via
% bootstrapping, working with reshaped data.
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
% true_mean a 3d array giving the true signal at each voxel.
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
% [ meanest, diff2truemean ] = lmbias();
%
% Using the global option:
% data = zeros([20, 91*109*91]);
% for I = 1:20
%     img = readimg(I);
%     data(I,:) = img(:);
% end 
% [ meanest, naiveest, trueval, top_lm_indices ] = lmbias(0, 20, 10, data);
% diff2truemean
%
% %Giving in data:
% data = zeros([20, 91*109*91]);
% for I = 1:20
%     img = readimg(I);
%     data(I,:) = img(:);
% end 
% [ meanest, naiveest, trueval, top_lm_indices ] = lmbias(1, 20, 10, data)
% diff2truemean
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport
if nargin < 1
    local = 1;
end
if nargin < 2
    B = 10;
end
if nargin < 3
    %Generates random data.
    data = zeros([20, 91*109*91]);
    for I = 1:20
        img = readimg(I);
        data(I,:) = img(:);
    end
    global TYPE
    if strcmp(TYPE,'jala')
        data = zeros([20, 91*109*91]);
        for I = 1:20
            img = readimg(I);
            data(I,:) = img(:);
        end
    else
        data = datagen(4,20);
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
    true_mean = NaN;
end

s = size(true_mean);
if s(1) ~= 1
    error('The true_mean vector must be a row vector')
end

[nSubj, nVox] = size(data);
[est_mean_vec, ~, est_mos_vec] = meanmos(data, 0);

if isnan(threshold)
    fwhm_est = est_smooth(reshape(data', [91,109,91, nSubj]));
    resel_vec = spm_resels_vol(mask, fwhm_est)';
    threshold = spm_uc( 0.05, [1,(nSubj-1)], 'T', resel_vec, 1 );
end

mask_of_greater_than_threshold = (sqrt(nSubj)*est_mos_vec > threshold);
mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;

[top_lm_indices, top] = lmindices(est_mos_vec, Inf, mask_of_greater_than_threshold);

if top == 0
    meanest = NaN;
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

    [mean_map, ~, mos_map] = meanmos(temp_data, 0);
    
    lm_indices = lmindices(mos_map, top, mask);
    if local == 1
        bias = bias + mean_map(lm_indices) - est_mean_vec(lm_indices);
    else
        bias = bias + mean_map(lm_indices) - est_mean_vec(top_lm_indices);
    end
end

bias = bias/B;
meanest = est_mean_vec(top_lm_indices) - bias;

% if local == 1
%     diff2truemean = meanest - true_mean(top_lm_indices);
% else
%     diff2truemean = meanest - true_mean(top_truemean_lm_indices);
% end

naiveest = est_mean_vec(top_lm_indices);
if isnan(true_mean);
    trueval = NaN;
else
    trueval = true_mean(top_lm_indices);
end

end

