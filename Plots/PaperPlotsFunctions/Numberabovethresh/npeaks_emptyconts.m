clear
stats = {'tstat', 'Fstat'};
types = {'npeaks', 'nabovethresh', 'ncomps'};

for enum = 1:length(stats)
    stat = stats{enum};
    for ntype = 1:length(types)
        nstore.(types{ntype}) = containers.Map('KeyType','int32', 'ValueType','any');
    end
    save(jgit(strcat('Plots/PaperPlots/Numberabovethresh/',stat,'_peaknumbers')),'nstore')
end
