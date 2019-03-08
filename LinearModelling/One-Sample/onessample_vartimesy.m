%With masking!

subs4mean = loaddata('subs4mean');
nsubj = length(subs4mean);
stor_loc = strcat(CSI, 'LinearModelling');
%% 
tic
global stdsize
maskedx = zeros(stdsize);
maskedy = zeros(stdsize);

for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    mask = readimg(subs4mean(I),'mask', 1);
    maskedy = maskedy + mask.*subject_image;
    maskedx = maskedx + mask;
    disp(I);
end

imgsave(maskedx,'maskx',stor_loc)
imgsave(maskedy,'masky',stor_loc)
toc
%%
MNImask = imgload('MNImask');
alphahat = zeros(stdsize);
tdenom = zeros(stdsize);

tic
%Note you don't have to store everything as X^TX is symmetric!
for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            if MNImask(I,J,K)
                XtY = maskedy(I,J,K);
                XtX = maskedx(I,J,K);
                XtXinv = inv(XtX);
                
                coeffs = XtXinv*XtY; %#ok<MINV>
                
                alphahat(I,J,K) = coeffs(1);
                tdenom(I,J,K) = XtXinv(1,1);
            end
        end
    end
end

imgsave(alphahat, 'one_sample_intercept', stor_loc)
toc
%% Generate sigma^2 image
tic
fprintf('Sigma^2 calculation\n')
subs4mean = loaddata('subs4mean');

sigma2 = zeros(stdsize);
for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    mask = readimg(subs4mean(I),'mask', 1);
    
    sigma2 = sigma2 + mask.*(subject_image - alphahat).^2;
    
    disp(I);
end

sigma2 = sigma2./(masky-1); %(n-p) in the denomimator, as p = 2!

imgsave(sigma2, 'one_sample_sigma2', stor_loc)
toc
%%
fprintf('t calculation\n')
tstatistic = nan(stdsize);
tic
for I = 1:91
    disp(I)
    for J = 1:109
        for K = 1:91
            tstatistic(I,J,K) = alphahat(I,J,K)/sqrt(sigma2(I,J,K)*tdenom(I,J,K));
        end
    end
end

imgsave(tstatistic, 'one_sample_t', stor_loc)
toc
%%
R2 = F2R(tstatistic.^2,maskx,1);
imgsave(R2,'one_sample_R2',stor_loc);

