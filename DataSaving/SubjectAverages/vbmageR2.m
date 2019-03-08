nsubj = 50;
global stdsize
Agevar = bbvars( 'Age', 0 );
xvar = Agevar(1:nsubj);
vbm_maskNAN = imgload('vbm_mask');

unsmoothed_data = zeros([nsubj, prod(stdsize)]);
for I = 1:nsubj
   img = readvbm(I,0,0);
   unsmoothed_data(I,:) = img(:); 
end

[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar', unsmoothed_data );
est_R2 = reshape(est_R2, stdsize);
imgsave(est_R2.*vbm_maskNAN, 'vbm_estimatedR2first50_unsmoothed')

smoothed_data = zeros([nsubj, prod(stdsize)]);
for I = 1:nsubj
   img = readvbm(I);
   smoothed_data(I,:) = img(:); 
end

[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar', smoothed_data );
est_R2 = reshape(est_R2, stdsize);
imgsave(est_R2.*vbm_maskNAN, 'vbm_estimatedR2first50_smoothed')

