fileID = fopen('/vols/Scratch/ukbiobank/nichols/subjs_vbm.txt','r');

A = textscan(fileID, '%s');
A = A{1};

lenA = length(A);

%Make a text file with the vbm subjects. Which you can then load as a
%matrix!
fid = fopen(jgit('DataSaving/SubjectLists/vbmsubjlist.txt'),'w');
for I = 1:lenA
    Ithline = A{I};
    fprintf(fid, '%s\n', Ithline(3:9));
end
fclose(fid);