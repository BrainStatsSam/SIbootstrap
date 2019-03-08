%Running the Full Sex Model

Sex = bbvars('Sex');
nsubj = length(Sex);

global stdsize
alphahat = nan(stdsize);
betahat = nan(stdsize);
tdenom = nan(stdsize);

SOM = imgload('SOM');
masksex = imgload('masksex');
masksex2 = imgload('masksex2');
masky = imgload('masky');
masksexy = imgload('masksexy');

MNImask = imgload('MNImask');


%Note you don't have to store everything as X^TX is symmetric!
for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            if MNImask(I,J,K)
                XtY = [masky(I,J,K);masksexy(I,J,K)];
                XtX = [SOM(I,J,K), masksex(I,J,K); masksex(I,J,K), masksex2(I,J,K)];
                XtXinv = inv(XtX);
                
                coeffs = XtXinv*XtY; %#ok<MINV>
                
                alphahat(I,J,K) = coeffs(1);
                betahat(I,J,K) = coeffs(2);
                
                tdenom(I,J,K) = XtXinv(2,2);
            end
        end
    end
end

imgsave(betahat, 'full_sexlm_sexcoeff', CSI)
imgsave(alphahat, 'full_sexlm_intercept', CSI)


%% Generate sigma^2 image
fprintf('Sigma^2 calculation\n')
subs4mean = loaddata('subs4mean');

sigma2 = zeros(stdsize);
for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    mask = readimg(subs4mean(I),'mask', 1);
    
    sigma2 = sigma2 + mask.*(subject_image - alphahat - betahat*Sex(I)).^2;
    
    disp(I);
end

sigma2 = sigma2./(SOM-2); %(n-p) in the denomimator, as p = 2!

imgsave(sigma2, 'full_sexlm_sigma2', CSI)

%%
fprintf('t calculation\n')
tsex = nan(stdsize);

for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            tsex(I,J,K) = betahat(I,J,K)/sqrt(sigma2(I,J,K)*tdenom(I,J,K));
        end
    end
end

imgsave(tsex, 'full_sexlm_tsex', CSI)

%%
R2 = F2R(tsex.^2,SOM,2);
imgsave(R2,'full_sexlm_R2sex',CSI);

