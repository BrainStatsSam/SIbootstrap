first25 = imgload('Figures/21stfirst25mosZERO');
second25 = imgload('Figures/21stsecond25mosZERO');

mos50 = imgload('Figures/21st50mosZERO');
fullmos = imgload('fullmos');

%%
first25indices = lmindices(first25, 1);
for I = 1:length(first25indices)
    convind(first25indices(I),1)
end
second25(first25indices)

%%
mos50indices = lmindices(mos50, 1);
convind(mos50indices,1)
mos50(mos50indices)

%%

fullmos = imgload('fullmos');
fullmosindices = lmindices(fullmos, 1);
convind(fullmosindices,1)
fullmos(mos50indices)
fullmos(first25indices)
