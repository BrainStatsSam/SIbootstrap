cd /data/fireback/davenpor/davenpor/jalagit/Plots/PaperPlots/Boxplots
%% mean
out20 = dispres_thresh('mean', 20);
out50 = dispres_thresh('mean', 50);

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
out20 = dispres_thresh('t', 20);
out50 = dispres_thresh('t', 50);

group_20_boot = ones(1,length(out20.biasnaive'));
group_20_is   = ones(1,length(out20.biasis'));
group_50_boot = ones(1,length(out50.biasnaive'));
group_50_is   = ones(1,length(out50.biasis'));
group_100_boot = ones(1,length(out100.biasnaive'));
group_100_is   = ones(1,length(out100.biasis'));
group2 = ones(1,length(out50.biasnaive'));
A = [out20.biasnaive', out20.biasis', out20.biasboot', out50.biasnaive', out50.biasis', out50.biasboot'] 
B = [group_20_boot, 2*group_20_is, 3*group_20_boot, 4*group_20_boot, 5*group_20_is, 6*group_20_boot]
boxplot([out20.biasnaive', out20.biasis', out20.biasboot', out50.biasnaive', out50.biasis', out50.biasboot'], [group_20_boot, 2*group_20_boot, 3*group_20_boot, 4*group2, 5*group2, 6*group2], 'symbol', '')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method bias over the significant peaks'))
ylim([-1,2])
ylabel('Bias')
set(0,'defaultAxesFontSize', 15);
% set(gcf, 'position', [500,500,1050,400])
export_fig(jgit('Plots/PaperPlots/Boxplots/boxplotbiastthresh.pdf'), '-transparent', '-nocrop')


%%
group_20_boot = ones(1,length(out20.MSEnaive'));
group2 = ones(1,length(out50.MSEnaive'));
boxplot([out20.MSEnaive', out20.MSEis', out20.MSEboot', out50.MSEnaive', out50.MSEis', out50.MSEboot'], [group_20_boot, 2*group_20_boot, 3*group_20_boot, 4*group2, 5*group2, 6*group2], 'symbol', '')
set(gca,'xticklabels',{'Naive','Data-Splitting','Bootstrap','Naive','Data-Splitting','Bootstrap'})
abline('v',3.5) 
title(strcat('Method MSE over the significant peaks'))
ylim([-0.1,1.6])
ylabel('MSE')
set(0,'defaultAxesFontSize', 15);
set(gcf, 'position', [0,0,600,400])
export_fig(jgit('Plots/PaperPlots/Boxplots/boxplotMSEtthresh.pdf'), '-transparent', '-nocrop')
