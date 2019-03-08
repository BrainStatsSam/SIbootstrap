Age = bbvars('Age');

subs4mean = loaddata('subs4mean');
nsubj = length(subs4mean);

Y = zeros(1, nsubj);

tic
for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    Y(I) = subject_image(444217);
    disp(I)
end
toc    

fit = fitlm(Age, Y);

save(strcat(CSI,'agelmfit'), 'fit')