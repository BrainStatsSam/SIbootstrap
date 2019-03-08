nsubj = 500;
global stdsize
Agevar = bbvars( 'Age', 0 );
xvar = Agevar(1:nsubj);
nsubjover2 = nsubj/2;
smoothed_data = zeros([nsubj, prod(stdsize)]);
vbm_maskNAN = imgload('vbm_mask');
vbm_maskNAN = vbm_maskNAN(:)';

for I = 1:nsubj
   img = readvbm(I);
   smoothed_data(I,:) = img(:); 
end

[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar(1:100)', smoothed_data(1:100,:));
imgsave(est_R2.*vbm_maskNAN, 'vbm_estimatedR2first100_smoothed')

[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar(1:200)', smoothed_data(1:200,:));
imgsave(est_R2.*vbm_maskNAN, 'vbm_estimatedR2first200_smoothed')

[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar(1:300)', smoothed_data(1:300,:));
imgsave(est_R2.*vbm_maskNAN, 'vbm_estimatedR2first300_smoothed')

[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar(1:400)', smoothed_data(1:400,:));
imgsave(est_R2.*vbm_maskNAN, 'vbm_estimatedR2first400_smoothed')

[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar', smoothed_data);
imgsave(est_R2.*vbm_maskNAN, 'vbm_estimatedR2first500_smoothed')

