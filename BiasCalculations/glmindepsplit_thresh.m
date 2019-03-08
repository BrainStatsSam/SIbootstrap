function [ R2_est, true, top_lm_indices ] = glmindepsplit_thresh( xvar, data, true_R2, mask, threshold )
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
if nargin < 3
    true_R2 = imgload('mos');
end
if nargin < 4
    mask = imgload('MNImask');
end
if nargin < 5
    threshold = NaN;
end

%Calculate the number of subjects
s = size(data);
nsubj = s(1);
nsubjover2 = floor(nsubj/2);

data_max = data(1:nsubjover2, :);

[ ~, ~, est_std_residuals, ~, ~, est_t ] = MVlm( xvar(1:nsubjover2), data_max );

Fstat = est_t.^2;

if isnan(threshold)
    fwhm_est = est_smooth(reshape(est_std_residuals', [91,109,91, nsubjover2]));
    resel_vec = spm_resels_vol(mask, fwhm_est)';
    threshold = spm_uc( 0.05, [1,(nsubjover2-1)], 'F', resel_vec, 1 );
end

mask_of_greater_than_threshold = Fstat > threshold;
mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;
% top = numOfConComps(mask_of_greater_than_threshold, 0.5, 3);

% top_lm_indices = lmindices(Fstat,top, mask);
[top_lm_indices, top] = lmindices(max_mean_vec, Inf, mask_of_greater_than_threshold);
if top == 0
    R2_est = NaN;
    true = NaN;
    return
end

data_est = data((nsubjover2 + 1):nsubj,:);
[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar((nsubjover2 + 1):nsubj), data_est );

R2_est = est_R2(top_lm_indices);
true_R2 = true_R2(:);
true = true_R2(top_lm_indices);

end

