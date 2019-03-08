%Construct a total mask for the fMRI data. Ie record 0 if some subject is
%missing data at a voxel and 1 if all subjects have data there.
%Only to run on jalapeno.

global stdsize
count_masks = zeros(stdsize);
N = 8945;
for I=1:N
    count_masks = count_masks + readimg(I,'mask',1);
    if mod(I,100) == 0
        disp(I);
    end
end

mask = (count_masks==N);
global parloc
imgsave( mask, 'total_mask', parloc)