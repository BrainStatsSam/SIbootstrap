%%
max_loc = 310159;

fit = loaddata('sexfit')

betahat = imgload('sexlm_sexcoeff');
betahat(max_loc)

R2 = imgload('sexlm_R2');
R2(max_loc)


%%
max_loc = 224913;

fit = loaddata('sexfitold')

betahat = imgload('sexlm_sexcoeff');
betahat(max_loc)

R2 = imgload('sexlm_R2');
R2(max_loc)


%% Age

max_loc = 328819;

fit = loaddata('agefit')

betahat = imgload('agelm_agecoeff');
betahat(max_loc)

R2 = imgload('agelm_R2');
R2(max_loc)