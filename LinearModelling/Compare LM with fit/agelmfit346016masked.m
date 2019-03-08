Age = bbvars('Age');

% betahat = imgload('agelm_agecoeff');
% loc = lmindices(betahat,1);

loc = 326016; 

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

fit = fitlm(Age_available, Y_available);

save(strcat(CSI,'availableat326016'),'Y_available', 'Age_available')

save(strcat(CSI,'agelmfit326016masked'), 'fit')
