file = '/vols/Scratch/ukbiobank/nichols/SelectiveInf/largefiles/SSmeanB50nsubj20Data.csv';

M = readtable(file);
M = table2array(M);

save('SSmean.mat', 'M')