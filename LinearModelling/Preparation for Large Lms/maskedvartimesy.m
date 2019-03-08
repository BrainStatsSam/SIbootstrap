%With masking!

Sex = bbvars('Sex');
Age = bbvars('Age');
nsubj = length(Sex);
subs4mean = loaddata('subs4mean');
%% 
global stdsize
maskedagey = zeros(stdsize);
maskedage = zeros(stdsize);
maskedage2 = zeros(stdsize);

maskedsexy = zeros(stdsize);
maskedsex = zeros(stdsize);
maskedsex2 = zeros(stdsize);

maskedagesexy = zeros(stdsize);
maskedagesex = zeros(stdsize);
maskedy = zeros(stdsize);

for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    mask = readimg(subs4mean(I),'mask', 1);
    
    maskedagey = maskedagey + mask.*subject_image*Age(I);
    maskedage  = maskedage + mask*Age(I);
    maskedage2 = maskedage2 + mask*(Age(I)^2);
    
    maskedsexy = maskedsexy + mask.*subject_image*Sex(I);
    maskedsex  = maskedsex + mask*Sex(I);
    maskedsex2 = maskedsex2 + mask*(Sex(I)^2);
    
    maskedagesexy = maskedagesexy + mask.*subject_image*Sex(I)*Age(I);
    maskedagesex = maskedagesex + mask.*Sex(I)*Age(I);
    
    maskedy = maskedy + mask.*subject_image;
    
    disp(I);
end

imgsave(maskedagey,'maskagey',CSI)
imgsave(maskedage,'maskage',CSI)
imgsave(maskedage2,'maskage2',CSI)

imgsave(maskedsexy,'masksexy',CSI)
imgsave(maskedsex,'masksex',CSI)
imgsave(maskedsex2,'masksex2',CSI)

imgsave(maskedagesexy,'maskagesexy',CSI)
imgsave(maskedagesex,'maskagesex',CSI)
imgsave(maskedy,'masky',CSI)
