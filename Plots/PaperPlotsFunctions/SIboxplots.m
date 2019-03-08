[top_av_boot20, top_av_is20, top_av_naive20, top_MSE_boot20, top_MSE_is20, top_MSE_naive20] = dispres('mean', 20, 50);
[top_av_boot50, top_av_is50, top_av_naive50, top_MSE_boot50, top_MSE_is50, top_MSE_naive50] = dispres('mean', 50, 50);


boxplot([top_av_naive20; top_av_is20; top_av_boot20; top_av_naive50; top_av_is50; top_av_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method Bias over the top 20 peaks'))
export_fig boxplot1mean.pdf -transparent -nocrop


cla

boxplot([top_MSE_naive20; top_MSE_is20; top_MSE_boot20; top_MSE_naive50; top_MSE_is50; top_MSE_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method MSE over the top 20 peaks'))
set(gcf, 'position', [500,500,900,400])
export_fig boxplot2mean.pdf -transparent -nocrop