% This script generates the mean from the images using the 4000 randomly
% chosen subjects.

subs4mean = loaddata('subs4mean');
MNImask = imgload('MNImask');
dilmask = imgload('MNImaskdil');

mask = MNImask.*dilmask;
maskNAN = zero2nan(mask);
nsubj = length(subs4mean);

global stdsize
vbm_mean_img = zeros(stdsize);

%This loops through all of the subjects that are to be used to calculate
%the random mean.
for I = subs4mean
    vbm_mean_img = readvbm(I, 1, 0) + vbm_mean_img; 
    %actual = 1 in readimg so that we take the actual subject list
    if mod(I,100) == 0
        disp(I)
    end
end

vbm_mean_img = (vbm_mean_img/nsubj).*mask;
vbm_mean_imgNAN = vbm_mean_img.*maskNAN;

imgsave(vbm_mean_img, 'vbm_mean_img', 2);
imgsave(vbm_mean_imgNAN, 'vbm_mean_imgNAN', 2);

%%
vbm_mask001 = ones(stdsize);
vbm_maskNAN = ones(stdsize);
vbm_mask01 = ones(stdsize);
vbm_maskNAN01 = ones(stdsize);

vbm_mean_img = imgload('vbm_mean_img');

vbm_mask001(vbm_mean_img < 0.01 ) = 0; %MNImask zero outside the brain so vbm_mean_img is so vbm_mask001 is too!
vbm_maskNAN(vbm_mean_img < 0.01) = NaN;

imgsave(vbm_mask001, 'vbm_mask001', 2);
imgsave(vbm_maskNAN, 'vbm_maskNAN001', 2);

vbm_mask01(vbm_mean_img < 0.1 ) = 0;
vbm_maskNAN01(vbm_mean_img < 0.1) = NaN;

imgsave(vbm_mask01, 'vbm_mask01', 2);
imgsave(vbm_maskNAN01, 'vbm_maskNAN01', 2);

