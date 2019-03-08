Sex = bbvars('Sex');
nsubj = length(Sex);

sexsum = sum(Sex);
sexsum2 = sum(Sex.^2);

XtX = [nsubj, sexsum;sexsum, sexsum2];
XtXinv = inv(XtX);

mean = imgload('mean');
nmean = nsubj*mean;
sexy = imgload('sexy');

global stdsize
alphahat = zeros(stdsize);
betahat = zeros(stdsize);

for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            XtY = [nmean(I,J,K);sexy(I,J,K)];
            coeffs = XtXinv*XtY;
            alphahat(I,J,K) = coeffs(1);
            betahat(I,J,K) = coeffs(2);
        end
    end
end

imgsave(betahat, 'r_sexlm_sexcoeff', CSI)
imgsave(alphahat, 'r_sexlm_intercept', CSI)


%% Generate sigma^2 image
subs4mean = loaddata('subs4mean');

sigma2 = 0;
for I = 1:nsubj
    disp(I);
    subject_image = readimg(subs4mean(I),'copes', 1);
    sigma2 = sigma2 + (subject_image - alphahat - betahat*Sex(I)).^2;
end

sigma2 = sigma2/(nsubj-1);

imgsave(sigma2, 'r_sexlm_sigma2', CSI)

%%
tsex = betahat./sqrt(sigma2*XtXinv(2,2));
MNImask = imgload('MNImask');
tsex = tsex.*MNImask;

imgsave(tsex, 'r_sexlm_tsex', CSI)

%%
R2 = F2R(tsex^2);
imgsave(R2,'r_sexlm_R2sex',CSI);



