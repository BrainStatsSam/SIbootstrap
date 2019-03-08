truebetahat = imgload('vbm_agelm_agecoeff');
mask = imgload('vbm_mask');

ind = lmindices(truebetahat, 1, mask);
convind(ind, 1)
truebetahat(ind)