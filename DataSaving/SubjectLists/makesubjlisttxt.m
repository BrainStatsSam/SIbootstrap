% Generate the list of subjects.

listimgs = dir('/vols/Scratch/ukbiobank/nichols/ContourInf/MNI/*_cope5_MNI.nii');

fid = fopen('subjlist.txt','w');
for I = 1:length(listimgs)
    fprintf(fid, '%s\n', listimgs(I).name(1:7));
end
fclose(fid);
