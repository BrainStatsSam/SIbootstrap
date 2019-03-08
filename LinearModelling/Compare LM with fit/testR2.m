SOM = imgload('SOM_MNI');
tage = imgload('agesexlm_tage');
tsex = imgload('agesexlm_tsex');

R2fromtage = F2R(tage.^2,SOM,2);

min(R2fromtage(:))
R2age = imgload('agesexlm_R2age');
min(R2age(:))