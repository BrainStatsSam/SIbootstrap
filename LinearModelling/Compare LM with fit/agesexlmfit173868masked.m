Age = bbvars('Age');
Sex = bbvars('Sex');

% betahat = imgload('agesexlm_sexcoeff');
% loc = lmindices(betahat,1);

loc = 173868; 

subs4mean = loaddata('subs4mean');
nsubj = length(subs4mean);

Y = zeros(1, nsubj);
Z = zeros(1, nsubj);

for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    mask = readimg(subs4mean(I),'mask', 1);
    Y(I) = subject_image(loc);
    Z(I) = mask(loc);
    disp(I)
end

Y_available = Y(logical(Z));
Age_available = Age(logical(Z));
Sex_available = Sex(logical(Z));

fit = fitlm([Age_available', Sex_available'], Y_available);

save(strcat(CSI,'availableat173868'),'Y_available', 'Age_available', 'Sex_available')

save(strcat(CSI,'agesexlmfit173868masked'), 'fit')
