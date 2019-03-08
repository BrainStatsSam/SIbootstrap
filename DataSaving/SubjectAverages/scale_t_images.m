smootht = imgload('smooth_vbm_agelm_tage');
mos = smootht/sqrt(4000);
imgsave(mos, 'smooth_vbm_agelm_mosage')

smootht_est = imgload('vbm_estimatedT2nd100_smoothed');
mos = smootht_est/sqrt(100);
imgsave(mos, 'vbm_estimatedmos2nd100_smoothed')