[top_av_boot20, top_av_is20, top_av_naive20, top_MSE_boot20, top_MSE_is20, top_MSE_naive20] = dispres('t', 20);
[top_av_boot50, top_av_is50, top_av_naive50, top_MSE_boot50, top_MSE_is50, top_MSE_naive50] = dispres('t', 50);


boxplot([top_av_naive20; top_av_is20; top_av_boot20; top_av_naive50; top_av_is50; top_av_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method Bias over the top 20 peaks'))
ylim([0,0.6])
ylabel('Bias')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [500,500,1050,400])
export_fig boxplot1t.pdf -transparent -nocrop

cla

boxplot([top_MSE_naive20; top_MSE_is20; top_MSE_boot20; top_MSE_naive50; top_MSE_is50; top_MSE_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method MSE over the top 20 peaks'))
ylim([0,0.4])
ylabel('MSE')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [500,500,1050,400])
export_fig boxplot2t.pdf -transparent -nocrop

%%
[top_av_boot20, top_av_is20, top_av_naive20, top_MSE_boot20, top_MSE_is20, top_MSE_naive20] = dispres('smootht', 20);
[top_av_boot50, top_av_is50, top_av_naive50, top_MSE_boot50, top_MSE_is50, top_MSE_naive50] = dispres('smootht', 50);


boxplot([top_av_naive20; top_av_is20; top_av_boot20; top_av_naive50; top_av_is50; top_av_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method Bias over the top 20 peaks'))
ylim([0,0.6])
ylabel('Bias')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [500,500,1050,400])
export_fig boxplot1smootht.pdf -transparent


cla

boxplot([top_MSE_naive20; top_MSE_is20; top_MSE_boot20; top_MSE_naive50; top_MSE_is50; top_MSE_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method MSE over the top 20 peaks'))
ylim([0,0.4])
ylabel('MSE')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [500,500,1050,400])
export_fig boxplot2smootht.pdf -transparent