nsubj = 50;
Agevar = bbvars( 'Age', 0 );
xvar = Agevar(1:nsubj);
vbm_maskNAN = imgload('vbm_mask');

voxel = convind([64,57,47]); %which is [63,56,46] in fsl.

smoothed_data = zeros(1,nsubj)';
unsmoothed_data = zeros(1,nsubj)';
for I = 1:nsubj
   img = readvbm(I);
   img = img(:);
   unsmoothed_img = readvbm(I,0,0);
   unsmoothed_img = unsmoothed_img(:);
   smoothed_data(I) = img(voxel); 
   unsmoothed_data(I) = unsmoothed_img(voxel);
   I
end

lm_smooth = fitlm(xvar, smoothed_data);
lm_unsmooth = fitlm(xvar, unsmoothed_data);

%%
[ coeffs, sigma2, std_residuals, fitted, R2, tvec, residuals ] = MVlm( xvar', unsmoothed_data );
coeffs(voxel)
sigma2(voxel)
R2(voxel)
tvec(voxel)