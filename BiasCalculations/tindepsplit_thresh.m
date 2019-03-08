function [ t_est, true, top_lm_indices ] = tindepsplit_thresh( data, true_mos, smooth_var, mask, threshold, estimate_mean)
% TINDEPSPLIT calculates a 50:50 split of the data and uses the first half
% to find the locations of the local maxima and the second half to find the 
% values observed there. Everything here is done in terms of t-testing.
%--------------------------------------------------------------------------
% ARGUMENTS
% which_subj    specifies which subjects to test on.
% top           specifies the top values to calculate the difference in
%               bias for.
% true_value    the underlying mos signal, note that this needs to be
%               adjusted (and is in the code below) to account for sample
%               size.
% estimate_mean 0/1 determines whether you're estimating the mean or cohen's
%               d. 0: cohen's d. 1: mean. Default: 0.
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% ImgMean = imgload('mos');
% nSubj = 40;
% nVox = 91*109*91;
% data = zeros([nSubj, nVox]);
% for I = 1:nSubj
%     img = readimg(I);
%     data(I,:) = img(:);
% end
% tindepsplit( data, 20, ImgMean);
%--------------------------------------------------------------------------
% SEE ALSO
% 
if nargin < 2
    true_mos = imgload('mos');
end
if nargin < 3
    smooth_var = 0;
end
if nargin < 4
    mask = imgload('MNImask');
end
if nargin < 5
     threshold = NaN;
end
if nargin < 6
    estimate_mean = 0;
end

%Calculate the number of subjects
s = size(data);
nsubj = s(1);
nsubjover2 = floor(nsubj/2);

%% First half of the data
data_max = data(1:nsubjover2, :);
[ ~, ~, max_mos ] = meanmos( data_max, smooth_var );

%% Thresholding
if isnan(threshold)
    fwhm_est = est_smooth(reshape(data_max', [91,109,91, nsubjover2]));
    resel_vec = spm_resels_vol(mask, fwhm_est)';
    threshold = spm_uc( 0.05, [1,(nsubjover2-1)], 'T', resel_vec, 1 );
end
mask_of_greater_than_threshold = sqrt(nsubjover2)*max_mos > threshold;
mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;
% top = numOfConComps(mask_of_greater_than_threshold, 0.5, 3); %Note 0.5 chosen here as its between 1 and 0 so that it removes the 0s should be zero anyways so this isn't necessary.

%% Find top indices
[top_lm_indices, top] = lmindices(max_mos, Inf, mask_of_greater_than_threshold);
if top == 0
    t_est = NaN;
    true = NaN;
    return
end

%% Second half of the data
data_est = data((nsubjover2 + 1):nsubj,:);
[ est_mean, ~, est_mos ] = meanmos( data_est, smooth_var );

if estimate_mean 
    t_est = est_mean(top_lm_indices);
else
    t_est = est_mos(top_lm_indices);
end

true_mos = true_mos(:);
true = true_mos(top_lm_indices);

end

