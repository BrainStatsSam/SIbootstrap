Age = bbvars('Age');
Sex = bbvars('Sex');
nsubj = length(Age);

agesum = sum(Age);
agesum2 = sum(Age.^2);
sexsum = sum(Sex);
sexsum2 = sum(Sex.^2);
agesex = sum(Age.*Sex);

XtX = [nsubj,agesum,sexsum; agesum, agesum2, agesex; sexsum, agesex, sexsum2];
XtXinv = inv(XtX);

mean = imgload('mean');
nmean = nsubj*mean;
agey = imgload('agey');
sexy = imgload('sexy');

global stdsize
alphahat = zeros(stdsize);
betahat = zeros(stdsize);
gammahat = zeros(stdsize);

for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            XtY = [nmean(I,J,K);agey(I,J,K);sexy(I,J,K)];
            coeffs = XtXinv*XtY;
            alphahat(I,J,K) = coeffs(1);
            betahat(I,J,K) = coeffs(2);
            gammahat(I,J,K) = coeffs(3);
        end
    end
end

imgsave(gammahat, 'r_agesexlm_sexcoeff', CSI)
imgsave(betahat, 'r_agesexlm_agecoeff', CSI)
imgsave(alphahat, 'r_agesexlm_intercept', CSI)


%% Generate sigma^2 image
subs4mean = loaddata('subs4mean');

sigma2 = 0;
for I = 1:nsubj
    disp(I);
    subject_image = readimg(subs4mean(I),'copes', 1);
    sigma2 = sigma2 + (subject_image - alphahat - betahat*Age(I) - gammahat*Sex(I)).^2;
end

sigma2 = sigma2/(nsubj-1);

imgsave(sigma2, 'r_agesexlm_sigma2', CSI)

%%
tage = betahat./sqrt(sigma2*XtXinv(2,2));
MNImask = imgload('MNImask');
tage = tage.*MNImask;

imgsave(tage, 'r_agesexlm_tage', CSI)

%%
tsex = gammahat./sqrt(sigma2*XtXinv(3,3));
MNImask = imgload('MNImask');
tsex = tsex.*MNImask;

imgsave(tsex, 'r_agesexlm_tsex', CSI)