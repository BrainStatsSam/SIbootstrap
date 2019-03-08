cd /data/fireback/davenpor/davenpor/jalagit/Plots/PaperPlots/Boxplots
%% mean
[top_av_boot20, top_av_is20, top_av_naive20, top_MSE_boot20, top_MSE_is20, top_MSE_naive20] = dispres('mean', 20);
[top_av_boot50, top_av_is50, top_av_naive50, top_MSE_boot50, top_MSE_is50, top_MSE_naive50] = dispres('mean', 50);


boxplot([top_av_naive20; top_av_is20; top_av_boot20; top_av_naive50; top_av_is50; top_av_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method Bias over the top 20 peaks'))
% ylim([0,0.6])
ylabel('Bias')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [500,500,1050,400])
export_fig boxplotbiasmean.pdf -transparent -nocrop

cla

boxplot([top_MSE_naive20; top_MSE_is20; top_MSE_boot20; top_MSE_naive50; top_MSE_is50; top_MSE_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method MSE over the top 20 peaks'))
% ylim([0,0.4])
ylabel('MSE')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [500,500,1050,400])
export_fig boxplotMSEmean.pdf -transparent -nocrop

%% t
[top_av_boot20, top_av_is20, top_av_naive20, top_MSE_boot20, top_MSE_is20, top_MSE_naive20] = dispres('t', 20);
[top_av_boot50, top_av_is50, top_av_naive50, top_MSE_boot50, top_MSE_is50, top_MSE_naive50] = dispres('t', 50);


boxplot([top_av_naive20; top_av_is20; top_av_boot20; top_av_naive50; top_av_is50; top_av_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method Bias over the top 20 peaks'))
% ylim([0,0.6])
ylabel('Bias')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [500,500,1050,400])
export_fig boxplotbiast.pdf -transparent -nocrop

cla

boxplot([top_MSE_naive20; top_MSE_is20; top_MSE_boot20; top_MSE_naive50; top_MSE_is50; top_MSE_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method MSE over the top 20 peaks'))
% ylim([0,0.4])
ylabel('MSE')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [500,500,1050,400])
export_fig boxplotMSEt.pdf -transparent -nocrop

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
export_fig boxplotbiassmootht.pdf -transparent


cla

boxplot([top_MSE_naive20; top_MSE_is20; top_MSE_boot20; top_MSE_naive50; top_MSE_is50; top_MSE_boot50]')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method MSE over the top 20 peaks'))
ylim([0,0.4])
ylabel('MSE')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [500,500,1050,400])
export_fig boxplotMSEsmootht.pdf -transparent

close all