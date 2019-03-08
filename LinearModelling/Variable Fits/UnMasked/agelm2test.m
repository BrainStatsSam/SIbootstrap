Age = bbvars('Age');

%%
agesum = sum(Age);
agesum2 = sum(Age.^2);
XtX = [nsubj,agesum;agesum, agesum2];
XtXinv = inv(XtX);

mean = imgload('mean');
nmean = nsubj*mean;
agey = imgload('agey');

global stdsize
alphahat = zeros(stdsize);
betahat = zeros(stdsize);

for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            XtY = [nmean(I,J,K);agey(I,J,K)];
            coeffs = XtXinv*XtY;
            alphahat(I,J,K) = coeffs(1);
            betahat(I,J,K) = coeffs(2);
        end
    end
end

imgsave(betahat, 'r_agelm_agecoeff2', CSI)
imgsave(alphahat, 'r_agelm_intercept2', CSI)
