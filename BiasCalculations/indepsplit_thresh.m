function [ mean_est, true, top_lm_indices ] = indepsplit_thresh( data, true_mean, mask, threshold)
% INDEPSPLIT calculates a 50:50 split of the data and uses the first half
% to find the locations of the local maxima and the second half to find the 
% values observed there. 
%--------------------------------------------------------------------------
% ARGUMENTS
% which_subj    specifies which subjects to test on.
% top           specifies the top values to calculate the difference in
%               bias for.
% true_value    the underlying mos signal, note that this needs to be
%               adjusted (and is in the code below) to account for sample
%               size.
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
    top = 20;
end
if nargin < 3
    true_mean = imgload('fullmean');
end
if nargin < 4
    mask = imgload('MNImask');
end

%Calculate the number of subjects
s = size(data);
nsubj = s(1);
nsubjover2 = floor(nsubj/2);

data_max = data(1:nsubjover2, :);
% max_mean = mean( data_max );
% top_lm_indices = lmindices(max_mean, top, mask);

size(data_max);
max_mean_vec = mean(data_max);
mask_of_greater_than_threshold = max_mean_vec > threshold;
mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;
% top = numOfConComps(mask_of_greater_than_threshold, 0.5, 3); %3 here is 3D!

[top_lm_indices, top] = lmindices(max_mean_vec, Inf, mask_of_greater_than_threshold);

if top == 0
    mean_est = NaN;
    true = NaN;
    return
end

data_est = data((nsubjover2 + 1):nsubj,:);
est_mean = mean( data_est );

mean_est = est_mean(top_lm_indices);
true_mean = true_mean(:);
true = true_mean(top_lm_indices);

end

