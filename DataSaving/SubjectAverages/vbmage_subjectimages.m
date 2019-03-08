nsubj = 50;
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

[ coeffs_first25, sigma2, ~, ~, est_R2_first_half, tvec ] = MVlm( xvar(1:nsubjover2)', smoothed_data(1:nsubjover2,:));
imgsave(est_R2_first_half.*vbm_maskNAN, 'vbm_estimatedR2first25_smoothed')
imgsave(tvec.*vbm_maskNAN, 'vbm_estimatedTfirst25_smoothed')
imgsave(coeffs_first25(1,:).*vbm_maskNAN, 'vbm_estimated_intercept_first25_smoothed')
imgsave(coeffs_first25(2,:).*vbm_maskNAN, 'vbm_estimated_agecoeff_first25_smoothed')
imgsave(sigma2.*vbm_maskNAN, 'vbm_estimated_sigma2_first25_smoothed')

[ coeffs_second25, sigma2, ~, ~, est_R2_second_half, tvec ] = MVlm( xvar((nsubjover2+1):nsubj)', smoothed_data((nsubjover2+1):nsubj,:));
imgsave(est_R2_second_half.*vbm_maskNAN, 'vbm_estimatedR2second25_smoothed')
imgsave(tvec.*vbm_maskNAN, 'vbm_estimatedTsecond25_smoothed')
imgsave(coeffs_second25(1,:).*vbm_maskNAN, 'vbm_estimated_intercept_second25_smoothed')
imgsave(coeffs_second25(2,:).*vbm_maskNAN, 'vbm_estimated_agecoeff_second25_smoothed')
imgsave(sigma2.*vbm_maskNAN, 'vbm_estimated_sigma2_second25_smoothed')


[ coeffs_first50, sigma2, ~, ~, est_R2, tvec ] = MVlm( xvar', smoothed_data );
imgsave(est_R2.*vbm_maskNAN, 'vbm_estimatedR2first50_smoothed')
imgsave(tvec.*vbm_maskNAN, 'vbm_estimatedTfirst50_smoothed')
imgsave(coeffs_first50(1,:).*vbm_maskNAN, 'vbm_estimated_intercept_first50_smoothed')
imgsave(coeffs_first50(2,:).*vbm_maskNAN, 'vbm_estimated_agecoeff_first50_smoothed')
imgsave(sigma2.*vbm_maskNAN, 'vbm_estimated_sigma2_first50_smoothed')

%%
nsubj = 100;
Agevar = bbvars( 'Age', 0 );
xvar = Agevar(101:(101+nsubj-1));
nsubjover2 = nsubj/2;
smoothed_data = zeros([nsubj, prod(stdsize)]);

for I = 1:nsubj
   img = readvbm(I+100);
   smoothed_data(I,:) = img(:); 
end

[ coeffs_3rd50, sigma2, ~, ~, est_R2_first_half, tvec ] = MVlm( xvar(1:nsubjover2)', smoothed_data(1:nsubjover2,:));
imgsave(est_R2_first_half.*vbm_maskNAN, 'vbm_estimatedR23rd50_smoothed')
imgsave(tvec.*vbm_maskNAN, 'vbm_estimatedT3rd50_smoothed')
imgsave(coeffs_3rd50(1,:).*vbm_maskNAN, 'vbm_estimated_intercept_3rd50_smoothed')
imgsave(coeffs_3rd50(2,:).*vbm_maskNAN, 'vbm_estimated_agecoeff_3rd50_smoothed')
imgsave(sigma2.*vbm_maskNAN, 'vbm_estimated_sigma2_3rd50_smoothed')

[ coeffs_4th50, sigma2, ~, ~, est_R2_second_half, tvec ] = MVlm( xvar((nsubjover2+1):nsubj)', smoothed_data((nsubjover2+1):nsubj,:));
imgsave(est_R2_second_half.*vbm_maskNAN, 'vbm_estimatedR24th50_smoothed')
imgsave(tvec.*vbm_maskNAN, 'vbm_estimatedT4th50_smoothed')
imgsave(coeffs_4th50(1,:).*vbm_maskNAN, 'vbm_estimated_intercept_4th50_smoothed')
imgsave(coeffs_4th50(2,:).*vbm_maskNAN, 'vbm_estimated_agecoeff_4th50_smoothed')
imgsave(sigma2.*vbm_maskNAN, 'vbm_estimated_sigma2_4th50_smoothed')

[ coeffs_2nd100,sigma2, ~, ~, est_R2, tvec ] = MVlm( xvar', smoothed_data );
imgsave(est_R2.*vbm_maskNAN, 'vbm_estimatedR2second100_smoothed')
imgsave(tvec.*vbm_maskNAN, 'vbm_estimatedT2nd100_smoothed')
imgsave(coeffs_2nd100(1,:).*vbm_maskNAN, 'vbm_estimated_intercept_2nd100_smoothed')
imgsave(coeffs_2nd100(2,:).*vbm_maskNAN, 'vbm_estimated_agecoeff_2nd100_smoothed')
imgsave(sigma2.*vbm_maskNAN, 'vbm_estimated_sigma2_2nd100_smoothed')

