%Running the Full Age Model

Age = bbvars('Age');
nsubj = length(Age);

global stdsize
alphahat = nan(stdsize);
betahat = nan(stdsize);
tdenom = nan(stdsize);

SOM = imgload('SOM');
maskage = imgload('maskage');
maskage2 = imgload('maskage2');
masky = imgload('masky');
maskagey = imgload('maskagey');

MNImask = imgload('MNImask');


%Note you don't have to store everything as X^TX is symmetric!
for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            if MNImask(I,J,K)
                XtY = [masky(I,J,K);maskagey(I,J,K)];
                XtX = [SOM(I,J,K), maskage(I,J,K); maskage(I,J,K), maskage2(I,J,K)];
                XtXinv = inv(XtX);
                
                coeffs = XtXinv*XtY; %#ok<MINV>
                
                alphahat(I,J,K) = coeffs(1);
                betahat(I,J,K) = coeffs(2);
                
                tdenom(I,J,K) = XtXinv(2,2);
            end
        end
    end
end

imgsave(betahat, 'full_agelm_agecoeff', CSI)
imgsave(alphahat, 'full_agelm_intercept', CSI)


%% Generate sigma^2 image
fprintf('Sigma^2 calculation\n')
subs4mean = loaddata('subs4mean');

sigma2 = zeros(stdsize);
for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    mask = readimg(subs4mean(I),'mask', 1);
    
    sigma2 = sigma2 + mask.*(subject_image - alphahat - betahat*Age(I)).^2;
    
    disp(I);
end

sigma2 = sigma2./(SOM-2);

imgsave(sigma2, 'full_agelm_sigma2', CSI)

%%
fprintf('t calculation\n')
tage = nan(stdsize);

for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            tage(I,J,K) = betahat(I,J,K)/sqrt(sigma2(I,J,K)*tdenom(I,J,K));
        end
    end
end

imgsave(tage, 'full_agelm_tage', CSI)

%%
R2 = F2R(tage.^2,SOM,2);
imgsave(R2,'full_agelm_R2age',CSI);

