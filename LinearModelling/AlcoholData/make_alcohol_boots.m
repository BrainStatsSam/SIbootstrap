X = readX;
c = zeros(1,16);
c(2) = -1;
alcohol_data = imgload('/home/fs0/topiwala/scratch/vbm527/stats/GM_mod_merg_s3.nii.gz');

data = zeros(527, 91*109*91);
for I = 1:527 
    img = alcohol_data(:,:,:,I);
    data(I, :) = img(:);
end

%%
[nSubj, nVox] = size(data);
out = MVlm_multivar( X, data, c, 0);
est_std_residuals = out.std_residuals;
est_fitted = out.fitted;

%%
% rng(123)
rng(125)
sample_index = randsample(nSubj,nSubj,1);

boot_residuals = est_std_residuals(sample_index, :);
boot_data = est_fitted + boot_residuals;
out_boot = MVlm_multivar( X, boot_data, c, 0 );

% save('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Results/alcohol_testing.mat','out', 'out_boot')

loc = 323278;
X*out.coeffs(:,loc)

%%
alcohol_mask = imgload('alcohol_mask.nii.gz');
alcohol_mask = alcohol_mask(:);
% imgsave(c*out.XtXinv*c', 'alcohol_testing/cXtXinvc')
imgsave(out.sigma2(:).*alcohol_mask, 'alcohol_testing/var')
imgsave(sqrt(out.sigma2'*(c*out.XtXinv*c')).*alcohol_mask, 'alcohol_testing/contrast_std')
imgsave(out_boot.R2(:).*alcohol_mask, 'alcohol_testing/boot_R2')
imgsave(out.R2(:).*alcohol_mask, 'alcohol_testing/actual_R2')
imgsave(out.coeffs(2, :)'.*alcohol_mask, 'alcohol_testing/alc_coeff')
imgsave(nan2zero(out.t(:)).*alcohol_mask, 'alcohol_testing/alc_tstat')
imgsave(fishtrans(sqrt(out.R2).*sign(out.t)).*alcohol_mask', 'alcohol_testing/alc_fish')

imgsave(out_boot.sigma2(:).*alcohol_mask, 'alcohol_testing/boot_var')
imgsave(sqrt(out_boot.sigma2'*(c*out.XtXinv*c')).*alcohol_mask, 'alcohol_testing/boot_contrast_std')
imgsave(out_boot.coeffs(2, :)'.*alcohol_mask, 'alcohol_testing/boot_alc_coeff')
imgsave(nan2zero(out_boot.t(:)).*alcohol_mask, 'alcohol_testing/alc_tstat_boot')
imgsave(fishtrans(sqrt(out_boot.R2).*sign(out_boot.t)).*alcohol_mask', 'alcohol_testing/boot_fish')

imgsave((mean(X*out.coeffs) - out.coeffs(1, :)).*alcohol_mask', 'alcohol_testing/mean')

