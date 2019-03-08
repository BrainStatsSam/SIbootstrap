M = loadres('tstat', 50, 'is');

B = 50;
groupsize = 50;
filending = strcat('Results/tstat','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
M = readtable(jgit(filending));

first_col = M{:,'simulation'};
for I = 1:98
    if length(find(first_col == I)) < 20
        I
    end
end