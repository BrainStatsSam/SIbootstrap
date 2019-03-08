X = readX;
c = zeros(1,16);
c(2) = -1;
alcohol_data = imgload('/home/fs0/topiwala/scratch/vbm527/stats/GM_mod_merg_s3.nii.gz');

size(alcohol_data) %= [91,109,91,527]
data = zeros(527, 91*109*91);
for I = 1:527 
    img = alcohol_data(:,:,:,I);
    data(I, :) = img(:);
end
clear alcohol_data
[ coeffs, sigma2, std_residuals, fitted, R2, tvec] = MVlm_multivar( X, data, c, 0 );
imgsave(tvec, 'alcohol_tstat')
imgsave(R2, 'alcohol_R2')
imgsave(sigma2, 'alcohol_sigma2')

alcohol_mean = mean(data);
imgsave(alcohol_mean, 'alcohol_mean');

%%
vbm_mask01 = imgload('vbm_maskNAN01');
vbm_mask001 = imgload('vbm_maskNAN001');
vbm_mask01 = vbm_mask01(:)';
vbm_mask001 = vbm_mask001(:)';

imgsave(tvec.*vbm_mask01, 'alcohol_tstat_01')
imgsave(R2.*vbm_mask01, 'alcohol_R2_01')
imgsave(sigma2.*vbm_mask01, 'alcohol_sigma2_01')

imgsave(tvec.*vbm_mask001, 'alcohol_tstat_001')
imgsave(R2.*vbm_mask001, 'alcohol_R2_001')
imgsave(sigma2.*vbm_mask001, 'alcohol_sigma2_001')

%%
%Note need to reload the alcohol_tstat as I overwrote it with the
%alcohol_tstat_mask!

alcohol_mask = imgload('alcohol_mask.nii.gz');
alcohol_R2 = imgload('alcohol_R2');
alcohol_tstat = imgload('alcohol_tstat');

alcohol_R2_mask = nan2zero(alcohol_R2.*alcohol_mask);
alcohol_tstat_mask = nan2zero(alcohol_tstat.*alcohol_mask);

imgsave(alcohol_R2_mask, 'alcohol_R2_mask');
imgsave(alcohol_tstat_mask, 'alcohol_tstat_mask');

%%
alcohol_R2_mask = imgload('alcohol_R2_mask');
alcohol_R2_maskandMNI = alcohol_R2_mask.*imgload('MNImask');
imgsave(alcohol_R2_maskandMNI, 'alcohol_R2_maskandMNI');