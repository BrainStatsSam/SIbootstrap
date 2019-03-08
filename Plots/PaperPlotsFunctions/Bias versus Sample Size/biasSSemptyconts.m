types = {'mean', 'tstat', 'smoothtstat'};

for enum = 1:length(types)
    type = types{enum};
    container = containers.Map('KeyType','int32', 'ValueType','any');
    save(jgit(strcat('Plots/PaperPlots/BiasvsSampleSize/',type,'MaxvsTruth')),'container')
end
