for type = {'tstat'}
    clf
    boxplots_boot(type{1}, 'bias')
end

%%
for type = {'t4lm'}
    clf
    boxplots_boot(type{1}, 'bias')
end


%%
for type = {'mean'}
    boxplots_boot(type{1}, 'bias')
end

%%
for type = {'vbmagesext'}
    boxplots_boot(type{1}, 'bias')
end


%%
% for type = {'tstat', 't4lm', 'mean'}
%     boxplots_boot(type{1}, 'var')
% end
% boxplots_boot('tstat', 'bias')