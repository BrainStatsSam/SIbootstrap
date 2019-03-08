function [ R2est, naiveest, top_lm_indices, trueval] = glmbias_thresh_multivar( local, B, X, data, true_R2, mask, contrast, threshold, use_inter)
% warning('This should just be true_R2 rather than true_R2.^2, I''ve left it like this for now in case it messes with the simulations that are running atm!')   
% GLMBIAS_THRESH_MULTIVAR takes in glm data and returns bootstrap corrected
% esimates of the partial R^2.
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
% xvar      An nsubj by 1 column vector with the varaible (nsubj is the 
%           number of subjects).    
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
% Random data generation:
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
    B = 50;
end
if nargin < 8
    threshold =  NaN;
end
if nargin < 9
    use_inter = 1;
end
if nargin < 10
    dominus = 0;
end

s = size(true_R2);
nvar = size(X,2);
if use_inter == 1
    nvar = nvar + 1;
end
if s(1) ~= 1
    error('The true_mean vector must be a row vector')
end

[nSubj, nVox] = size(data);
out = MVlm_multivar( X, data, contrast, use_inter );
est_std_residuals = out.std_residuals;
est_fitted = out.fitted;
est_R2 = out.R2;
est_t = out.tstat;
evalin( 'base', 'clear data' ) %Gets rid of data because it can take up a lot of space!

Fstat = est_t.^2;
    
if isnan(threshold)
    %Use RFT to set the threshold if one hasn't been provided.
    fwhm_est = est_smooth(reshape(est_std_residuals', [91,109,91, nSubj]));
    resel_vec = spm_resels_vol(mask, fwhm_est)';
    
    threshold = spm_uc( 0.05, [1,(nSubj-nvar)], 'F', resel_vec, 1 );
end

mask_of_greater_than_threshold = Fstat > threshold;
mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;
top = numOfConComps(mask_of_greater_than_threshold, 0.5, 3);

top_lm_indices = lmindices(Fstat,top, mask);

if strcmp(top, 'all')
    top = nVox;
end

R2_bias = 0;

for b = 1:B
    sample_index = randsample(nSubj,nSubj,1);
    boot_residuals = est_std_residuals(sample_index, :);
    boot_data = est_fitted + boot_residuals;
    out = MVlm_multivar( X, boot_data, contrast, use_inter );
    boot_R2 = out.R2;
    lm_indices = lmindices(boot_R2, top, mask); %NOTE MASKING OUT NANS FOR NOW!!
    
    if local == 1
        R2_bias = R2_bias + boot_R2(lm_indices) - est_R2(lm_indices);
    else
        R2_bias = R2_bias + boot_R2(lm_indices) - est_R2(top_lm_indices);
    end
end

R2_bias = R2_bias/B;
R2est = est_R2(top_lm_indices) - R2_bias;
naiveest = est_R2(top_lm_indices);

if isnan(true_R2)
    trueval = NaN;
else
    true_R2 = true_R2.^2; 
    warning('This should just be true_R2 rather than true_R2.^2, I''ve left it like this for now in case it messes with the simulations that are running atm!')
    trueval = true_R2(top_lm_indices);
end

end

