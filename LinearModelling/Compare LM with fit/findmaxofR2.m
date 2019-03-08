R2 = imgload('sexlm_R2sex');
max(R2(:))

max_loc = lmindices(R2, 1)

%%
beta = imgload('agesexlm_sexcoeff');
max(beta(:))

max_loc = lmindices(beta, 1)
%%
per = imgload('percent');
per(max_loc)

%% VBM

R2 = imgload('smooth_vbm_agesexlm_R2age');
max(R2(:))

max_loc = lmindices(R2, 1)
R2(max_loc)