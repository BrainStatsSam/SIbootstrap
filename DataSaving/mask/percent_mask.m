%Construct a percentage mask for the fMRI data. Ie at each voxel record the
%percent of subejcts that have data at that voxel.
%Only to run on jalapeno.

global stdsize
global CSI
per_masks = zeros(stdsize);
N = 8945;
for I=1:N
    per_masks = per_masks + readimg(I,'mask',1);
    if mod(I,100) == 0
        disp(I);
    end
end

per_masks = per_masks/N*100;
imgsave( per_masks, 'percentmask', CSI)