loc = 224913;
nsubj = 4000;

mean = imgload('mean');
nmean = nsubj*mean;
nmean(loc)

sexy = imgload('sexy');
sexy(loc)


%%
mean = imgload('r_mean');
nmean = nsubj*mean;
nmean(loc)