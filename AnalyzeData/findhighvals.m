%Find the highest values in the variance images.

subjects = csvread('subjlist.txt');
%fid = fopen('subjlist.txt');
%subjects = textscan(fid, '%s', 8945, 'delimiter', '\n');
%fclose(fid);

no4mean = 5000;

global stdsize
mean_img2 = zeros(stdsize);

for I = 1:100
    file = strcat('/vols/Scratch/ukbiobank/nichols/ContourInf/MNI/', num2str(subjects(I)), '_fMRI_varcope5_MNI.nii.gz');
    img = spm_read_vols(spm_vol(file));
    m = max(img(:));
    disp(m)
    if mod(I,100) == 0
        disp(I)
    end
end

mean_img2 = mean_img2/no4mean;