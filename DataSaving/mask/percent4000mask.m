%Construct a percentage mask for the fMRI data for the 4000 subjects.
global CSI

global stdsize
per_masks = zeros(stdsize);
subs4mean = loaddata('subs4mean');
for I = subs4mean
    per_masks = per_masks + readimg(I,'mask',1);
    if mod(I,100) == 0
        disp(I);
    end
end

imgsave( per_masks, 'nsubs4000mask', CSI)
per_masks = per_masks/N*100;
MNImask = zero2nan(imgload('MNImask'));
per_masks = per_masks.*MNImask;
imgsave( per_masks, 'percent4000mask', CSI)