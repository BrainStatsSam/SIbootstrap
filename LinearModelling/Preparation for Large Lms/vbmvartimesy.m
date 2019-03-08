%VBM multiplying variables with the images.

Sex = bbvars('Sex');
Age = bbvars('Age');
nsubj = length(Sex);
subs4mean = loaddata('subs4mean');
%% 
global stdsize
agey = zeros(stdsize);
sexy = zeros(stdsize);
agesexy = zeros(stdsize);

for I = 1:nsubj
    subject_image = readvbm(subs4mean(I),1,0);
    
    agey = agey + subject_image*Age(I);
    
    sexy = sexy + subject_image*Sex(I);
    
    agesexy = agesexy + subject_image*Sex(I)*Age(I);
    
    disp(I);
end

agey = agey.*MNImask;
sexy = sexy.*MNImask;
agesexy = agesexy.*MNImask;

imgsave(agey,'vbmagey',CSI)
imgsave(sexy,'vbmsexy',CSI)
imgsave(agesexy,'vbmagesexy',CSI)
