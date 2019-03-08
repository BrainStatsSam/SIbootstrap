Age = bbvars('Age');
Sex = bbvars('Sex');
Agevar = bbvars( 'Age', 0 );
Sexvar = bbvars( 'Sex', 0);
nsubj = length(Age);

% betahat = imgload('agelm_agecoeff');
% loc = lmindices(betahat,1);

loc = 342934; 

subs4mean = loaddata('subs4mean');

Y = zeros(1, nsubj);

for I = 1:nsubj
    subject_image = readvbm(subs4mean(I), 1);
    Y(I) = subject_image(loc);
    disp(I)
end
save(strcat(CSI,'smooth_vbm_agesexlm_326016'),'Y', 'Age', 'Sex')

fit = fitlm([Age; Sex], Y);

save(strcat(CSI,'smooth_vbm_agesexlm_326016'),'Y', 'Age', 'Sex', 'fit')

%%
load(strcat(CSI,'smooth_vbm_agesexlm_326016'),'Y', 'Age', 'Sex')
fit = fitlm([Age', Sex'], Y')
fit2 = myfit([Age', Sex'], Y');
fit2.partialR2
fit2.f2
fit2.partialR2./(1-fit2.partialR2)
R2 = imgload('smooth_vbm_agesexlm_R2age');
R2(342934)

agecoeff = imgload('smooth_vbm_agesexlm_agecoeff');
agecoeff(342934)