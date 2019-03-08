%Running the Full Age Model

Age = bbvars('Age');
Sex = bbvars('Sex');
nsubj = length(Age);

global stdsize
interhat = nan(stdsize);
sexhat = nan(stdsize);
agehat = nan(stdsize);
tagedenom = nan(stdsize);
tsexdenom = nan(stdsize);

SOM = imgload('SOM');
masky = imgload('masky');

maskage = imgload('maskage');
maskage2 = imgload('maskage2');
maskagey = imgload('maskagey');

masksex = imgload('masksex');
masksex2 = imgload('masksex2');
masksexy = imgload('masksexy');

maskagesexy = imgload('maskagesexy');
maskagesex = imgload('maskagesex');

MNImask = imgload('MNImask');

%Note you don't have to store everything as X^TX is symmetric!
for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            if MNImask(I,J,K)
                XtY = [masky(I,J,K);maskagey(I,J,K); masksexy(I,J,K)];
                XtX = [SOM(I,J,K), maskage(I,J,K), masksex(I,J,K); maskage(I,J,K), maskage2(I,J,K), maskagesex(I,J,K); masksex(I,J,K), maskagesex(I,J,K), masksex2(I,J,K)];
                XtXinv = inv(XtX);
                
                coeffs = XtXinv*XtY; %#ok<MINV>
                
                interhat(I,J,K) = coeffs(1);
                agehat(I,J,K) = coeffs(2);
                sexhat(I,J,K) = coeffs(3);
                
                tagedenom(I,J,K) = XtXinv(2,2);
                tsexdenom(I,J,K) = XtXinv(3,3);
            end
        end
    end
end

imgsave(sexhat, 'full_agesexlm_sexcoeff', CSI)
imgsave(agehat, 'full_agesexlm_agecoeff', CSI)
imgsave(interhat, 'full_agesexlm_intercept', CSI)


%% Generate sigma^2 image
fprintf('Sigma^2 calculation\n')
subs4mean = loaddata('subs4mean');

sigma2 = zeros(stdsize);
for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    mask = readimg(subs4mean(I),'mask', 1);
    
    sigma2 = sigma2 + mask.*(subject_image - interhat - agehat*Age(I) - sexhat*Sex(I)).^2;
    
    disp(I);
end

sigma2 = sigma2./(SOM-2);

imgsave(sigma2, 'full_agesexlm_sigma2', CSI)

%%
fprintf('t calculation\n')
tage = nan(stdsize);
tsex = nan(stdsize);

for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            tage(I,J,K) = agehat(I,J,K)/sqrt(sigma2(I,J,K)*tagedenom(I,J,K));
            tsex(I,J,K) = agehat(I,J,K)/sqrt(sigma2(I,J,K)*tsexdenom(I,J,K)); %Needs to be sexhat!
        end
    end
end

imgsave(tage, 'full_agesexlm_tage', CSI)
imgsave(tsex, 'full_agesexlm_tsex', CSI)

%% This was what we did before, but it takes p = 2 instead of p = 3!
R2age = F2R(tage.^2,SOM,2);
imgsave(R2age,'full_agesexlm_R2age',CSI);

R2sex = F2R(tsex.^2,SOM,2);
imgsave(R2sex,'full_agesexlm_R2sex',CSI);

%%
tage = imgload('full_agesexlm_tage');
tsex = imgload('full_agesexlm_tsex');

[R2age,f2age] = F2R(tage.^2,SOM,3, 1);
imgsave(R2age,'full_agesexlm_R2age',CSI);
imgsave(f2age,'full_agesexlm_f2age',CSI);

[R2sex,f2sex] = F2R(tsex.^2,SOM,3, 1);
imgsave(R2sex,'full_agesexlm_R2sex',CSI);
imgsave(f2sex,'full_agesexlm_f2sex',CSI);
