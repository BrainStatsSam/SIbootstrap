%Running the Full Sex Model

Sex = bbvars('Sex');
nsubj = length(Sex);

global stdsize
alphahat = nan(stdsize);
betahat = nan(stdsize);
tdenom = nan(stdsize);

sum_of_ys = imgload('vbm_mean_img').*nsubj;
sexy = imgload('vbmsexy');

vbm_mask = imgload('vbm_mask');

XtX = [nsubj, sum(Sex); sum(Sex), sum(Sex.^2)];
XtXinv = inv(XtX);

%Note you don't have to store everything as X^TX is symmetric!
for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            if vbm_mask(I,J,K)
                XtY = [sum_of_ys(I,J,K); sexy(I,J,K)];
                
                coeffs = XtXinv*XtY; %#ok<MINV>
                
                alphahat(I,J,K) = coeffs(1);
                betahat(I,J,K) = coeffs(2);
                
                tdenom(I,J,K) = XtXinv(2,2);
            end
        end
    end
end

imgsave(betahat, 'vbm_sexlm_sexcoeff', CSI)
imgsave(alphahat, 'vbm_sexlm_intercept', CSI)


%% Generate sigma^2 image
fprintf('Sigma^2 calculation\n')
subs4mean = loaddata('subs4mean');

sigma2 = zeros(stdsize);
for I = 1:nsubj
    subject_image = readvbm(subs4mean(I), 1);
    
    sigma2 = sigma2 + (subject_image - alphahat - betahat*Sex(I)).^2;
    
    disp(I);
end

sigma2 = sigma2/(nsubj-2); %(n-p) in the denomimator, as p = 2!
sigma2 = sigma2.*vbm_mask; 

imgsave(sigma2, 'vbm_sexlm_sigma2', CSI)

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

imgsave(tsex, 'vbm_sexlm_tsex', CSI)

%%
R2 = F2R(tsex.^2,nsubj,2);
imgsave(R2,'vbm_sexlm_R2sex',CSI);

