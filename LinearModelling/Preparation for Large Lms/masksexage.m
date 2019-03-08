%Guess I did this separately. Bit Deprecated I think.

Sex = bbvars('Sex');
Age = bbvars('Age');
nsubj = length(Sex);
subs4mean = loaddata('subs4mean');
%% 
global stdsize
maskedagesex = zeros(stdsize);

for I = 1:nsubj
    mask = readimg(subs4mean(I),'mask', 1);
    maskedagesex = maskedagesex + mask.*Sex(I)*Age(I);
    disp(I);
end

imgsave(maskedagesex,'maskagesex',CSI)
