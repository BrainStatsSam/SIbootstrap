std_dev = imgload('fullstd');
sig = imgload('fullmean');

mean(std_dev(~isnan(std_dev)))/sqrt(100)

mean(sig(~isnan(sig)))