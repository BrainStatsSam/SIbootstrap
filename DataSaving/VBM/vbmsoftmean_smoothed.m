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
    vbm_mean_img = readvbm(I, 1) + vbm_mean_img; 
    %actual = 1 in readimg so that we take the actual subject list
    if mod(I,100) == 0
        disp(I)
    end
end

vbm_smooth_mean_img = (vbm_mean_img/nsubj).*mask;
vbm_smooth_mean_imgNAN = vbm_mean_img.*maskNAN;

imgsave(vbm_smooth_mean_img, 'vbm_smooth_mean_img', 2);
imgsave(vbm_smooth_mean_imgNAN, 'vbm_smooth_mean_imgNAN', 2);

