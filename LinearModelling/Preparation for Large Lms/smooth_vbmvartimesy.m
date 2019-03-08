%VBM multiplying variables with the images.

Sex = bbvars('Sex');
Age = bbvars('Age');
nsubj = length(Sex);
subs4mean = loaddata('subs4mean');
vbm_maskNAN = imgload('vbm_maskNAN');
%% 
global stdsize
agey = zeros(stdsize);
sexy = zeros(stdsize);
agesexy = zeros(stdsize);

for I = 1:nsubj
    subject_image = readvbm(subs4mean(I),1);
    
    agey = agey + subject_image*Age(I);
    
    sexy = sexy + subject_image*Sex(I);
    
    agesexy = agesexy + subject_image*Sex(I)*Age(I);
    
    disp(I);
end

agey = agey.*vbm_maskNAN;
sexy = sexy.*vbm_maskNAN;
agesexy = agesexy.*vbm_maskNAN;

imgsave(agey,'smooth_vbmagey',CSI)
imgsave(sexy,'smooth_vbmsexy',CSI)
imgsave(agesexy,'smooth_vbmagesexy',CSI)
