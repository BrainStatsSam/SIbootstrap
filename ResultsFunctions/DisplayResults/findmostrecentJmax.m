%Find the most recent Jmax.

groupsize = 20;
B = 50;
filending = strcat('Results/tabularJmax',num2str(Jmax),'B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
M = readtable(jgit(filending));
Jmaxlist = M{:,'simulation'};
Jcurrentmax = Jmaxlist(end);