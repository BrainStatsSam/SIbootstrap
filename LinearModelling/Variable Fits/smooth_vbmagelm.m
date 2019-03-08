%Running the VBM Age Model

Age = bbvars('Age');
nsubj = length(Age);

global stdsize
alphahat = nan(stdsize);
betahat = nan(stdsize);
tdenom = nan(stdsize);

sum_of_ys = imgload('vbm_smooth_mean_img').*nsubj;
agey = imgload('smooth_vbmagey');

vbm_mask = imgload('vbm_mask');

XtX = [nsubj, sum(Age); sum(Age), sum(Age.^2)];
XtXinv = inv(XtX);

%Note you don't have to store everything as X^TX is symmetric!
for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            if vbm_mask(I,J,K)
                XtY = [sum_of_ys(I,J,K); agey(I,J,K)];
                
                coeffs = XtXinv*XtY; %#ok<MINV>
                
                alphahat(I,J,K) = coeffs(1);
                betahat(I,J,K) = coeffs(2);
                
                tdenom(I,J,K) = XtXinv(2,2);
            end
        end
    end
end

imgsave(betahat, 'smooth_vbm_agelm_agecoeff', CSI)
imgsave(alphahat, 'smooth_vbm_agelm_intercept', CSI)


%% Generate sigma^2 image
fprintf('Sigma^2 calculation\n')
subs4mean = loaddata('subs4mean');

sigma2 = zeros(stdsize);
for I = 1:nsubj
    subject_image = readvbm(subs4mean(I), 1);
    
    sigma2 = sigma2 + (subject_image - alphahat - betahat*Age(I)).^2;
    
    disp(I);
end

sigma2 = sigma2/(nsubj-2); %(n-p) in the denomimator, as p = 2!
sigma2 = sigma2.*vbm_mask; 

imgsave(sigma2, 'smooth_vbm_agelm_sigma2', CSI)

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

imgsave(tage, 'smooth_vbm_agelm_tage', CSI)

%%
R2 = F2R(tage.^2,nsubj,2);
imgsave(R2,'smooth_vbm_agelm_R2age',CSI);

