%% Code to generate the Figures which compare circular and bootstrap estimates


for type = {'tstat'}
    for groupsize = [50]
        circvsbootplots_gen( type{1}, groupsize )
    end
end

%%
for type = {'tstat', 't4lm', 'mean'}
    for groupsize = [20,50,100]
        circvsbootplots_gen( type{1}, groupsize )
        pause
    end
end

%%
for type = {'R2'}
    for groupsize = [50,100,150]
        circvsbootplots_gen( type{1}, groupsize )
    end
end
