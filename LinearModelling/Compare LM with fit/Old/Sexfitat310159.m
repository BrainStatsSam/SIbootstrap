Sex = bbvars('Sex');

subs4mean = loaddata('subs4mean');
nsubj = length(subs4mean);

Y = zeros(1, nsubj);

for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    Y(I) = subject_image(310159);
    disp(I)
end

fit = fitlm(Sex, Y);

save(strcat(CSI,'sexlmfit'), 'fit')