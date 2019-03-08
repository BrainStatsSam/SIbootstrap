firstR2 = imgload('vbm_estimatedR23rd50_smoothed');
secondR2 = imgload('vbm_estimatedR24th50_smoothed');
fullR2 = imgload('vbm_estimatedR2second100_smoothed');

% lmindices(firstR2,1)
loc = lmindices(fullR2,1);
convind(loc,1)