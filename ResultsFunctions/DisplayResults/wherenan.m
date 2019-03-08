%Determine where the nan entries are in the results

M = readcsv(jgit('Results/meanB50nsubj20Data.csv'));
where_nans = isnan(M);
sum(where_nans(:))
find(isnan(M))