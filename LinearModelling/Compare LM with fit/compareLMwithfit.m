fit = loaddata('sexfitmask')

loc = 234820;

alphahat = imgload('sexlm_intercept');
betahat = imgload('sexlm_sexcoeff');
t = imgload('sexlm_tsex');
R2 = imgload('sexlm_R2sex');
sigma2 = imgload('sexlm_sigma2');

alphahat(loc)
betahat(loc)
t(loc)
R2(loc)
sigma2(loc)

%%
%Compare the fit at a given voxel with the overall fit having incorporated
%masking.

fit = loaddata('sexfitmaskold')

loc = 224913;

alphahat = imgload('sexlm_intercept');
betahat = imgload('sexlm_sexcoeff');
t = imgload('sexlm_tsex');
R2 = imgload('sexlm_R2sex');
sigma2 = imgload('sexlm_sigma2');

alphahat(loc)
betahat(loc)
t(loc)
R2(loc)
sigma2(loc)

%%
fit = loaddata('agefitmask')

loc = 346016;

alphahat = imgload('agelm_intercept');
betahat = imgload('agelm_agecoeff');
t = imgload('agelm_tage');
R2 = imgload('agelm_R2age');
sigma2 = imgload('agelm_sigma2');

alphahat(loc)
betahat(loc)
t(loc)
R2(loc)
sigma2(loc)

%%
fit = loaddata('agesexfitmask')

loc = 173868;

alphahat = imgload('agesexlm_intercept');
betahat = imgload('agesexlm_agecoeff');
t = imgload('agesexlm_tage');
R2 = imgload('agesexlm_R2age');
sigma2 = imgload('agesexlm_sigma2');

alphahat(loc)
betahat(loc)
t(loc)
R2(loc)
sigma2(loc)



