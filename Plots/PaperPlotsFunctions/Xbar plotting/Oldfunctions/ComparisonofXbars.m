%% ests versus truth

%This file plots the Xbars against each other. (Can change tstat to
%smoothtstat
%to mean etc. Really need to re-run this but with just the maxima or a
%decrease in data anyhow, as its confusing as presented.


% M = readtable(jgit('Results/tstatB50nsubj20Data.csv'));

M = readtable(jgit('Results/smoothtstatB50nsubj20Data.csv'));
M = table2array(M);

peaksnos = M(:,2);
toptenlocs = find2(peaksnos, 1:10);

cla
p1 = plot(M(:,5), M(:,7),'o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(M(:,5), M(:,4),'o');
set(p2,'LineWidth',1.5);
p3 = plot(M(:,5), M(:,3),'o');
set(p3,'LineWidth',1.5);
xlabel('True Xbar')
ylabel('Xbar estimate')
% abline(0,1,'color',[128,128,128])
pbaspect([1 1 1])
xlim([0,1.6])
ylim([-1,3])
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
title('Plotting the Estimates against the true values')
legend('indepsplit','naive','boot', 'Location','NorthWest')
export_fig(jgit('Plots/PaperPlots/ComparisonofXbars/estvstruth_all.pdf'), '-transparent')

%% ests versus truth: indi plots
cla
plot(M(:,5), M(:,7),'o','LineWidth',1.5);
pbaspect([1 1 1])
xlim([0,1.6])
ylim([-1,3])
title('Plotting the Estimates against the true values')
legend('Data Splitting', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit('Plots/PaperPlots/ComparisonofXbars/estvstruth_indi_DS.pdf'), '-transparent')

cla
plot(M(:,5), M(:,4),'o','LineWidth',1.5, 'color', 'red');
pbaspect([1 1 1])
xlim([0,1.6])
ylim([-1,3])
title('Plotting the Estimates against the true values')
legend('Naive', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit('Plots/PaperPlots/ComparisonofXbars/estvstruth_indi_naive.pdf'), '-transparent')


cla
plot(M(:,5), M(:,3),'o','LineWidth',1.5, 'color', 'cyan');
xlabel('True Xbar')
ylabel('Xbar estimate')
% abline(0,1,'color',[128,128,128])
pbaspect([1 1 1])
abline(0,1,'color',[1,1,1]/2,'linestyle', '-')
xlim([0,1.6])
ylim([-1,3])
title('Plotting the Estimates against the true values')
legend('Bootstrap', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit('Plots/PaperPlots/ComparisonofXbars/estvstruth_indi_boot.pdf'), '-transparent')

%% Just the maxima ests versus truth
% M = readtable(jgit('Results/tstatB50nsubj20Data.csv'));
M = readtable(jgit('Results/smoothtstatB50nsubj20Data.csv'));

M.Properties.VariableNames

M = table2array(M);


naive = M(:,4);
truenaiveboot = M(:,5);
is = M(:,7);
boot = M(:,3);
trueatlocis = M(:,8);

subset = 1:20:2000; %Just gives the maxima.


cla
p1 = plot(truenaiveboot(subset), is(subset),'o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(truenaiveboot(subset), naive(subset),'o');
set(p2,'LineWidth',1.5);
p3 = plot(truenaiveboot(subset),boot(subset),'o');
set(p3,'LineWidth',1.5);
xlabel('True Xbar')
ylabel('Xbar estimate')
refline(1,0)
pbaspect([1 1 1])
xlim([0,1.6])
ylim([-1,3])
title('Plotting the Estimates against the true values')
legend('Data Splitting','Naive','Bootstrap', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit('Plots/PaperPlots/ComparisonofXbars/maxima_estvstruth.pdf'), '-transparent')

%% All. Ests versus Naive

cla
p2 = plot(naive,is,'o');
set(p2,'LineWidth',1.5);
hold on
p1 = plot(naive,boot,'o');
set(p1,'LineWidth',1.5);
xlabel('Naive Xbar')
ylabel('Unbiased Xbar')
rline = refline(1,0);
rline.Color = 'b';
pbaspect([1 1 1])
xlim([0.7,2.5])
ylim([-1,3])
title('Plotting the Estimates against the Naive values')
legend('Data Splitting', 'Bootstrap', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit('Plots/PaperPlots/ComparisonofXbars/estsvsnaive.pdf'), '-transparent')

%% Just the maxima. Ests versus Naive.

subset = 1:20:2000; %Just gives the maxima.


cla
p2 = plot(naive(subset),is(subset),'o');
set(p2,'LineWidth',1.5);
hold on
p1 = plot(naive(subset),boot(subset),'o');
set(p1,'LineWidth',1.5);
xlabel('Naive Xbar')
ylabel('Unbiased Xbar')
refline(1,0)
xlim([1.2,2.4])
ylim([-0.5,2.5])
pbaspect([1 1 1])

title('Plotting the Estimates against the Naive values')
legend('Data Splitting', 'Bootstrap', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit('Plots/PaperPlots/ComparisonofXbars/maxima_estsvsnaive.pdf'), '-transparent')

%% Topten ests versus truth

M = readtable(jgit('Results/smoothtstatB50nsubj20Data.csv'));

M.Properties.VariableNames

M = table2array(M);

peaksnos = M(:,2);
subset = find2(peaksnos, 1:10);

naive = M(:,4);
truenaiveboot = M(:,5);
is = M(:,7);
boot = M(:,3);
trueatlocis = M(:,8);


cla
p1 = plot(truenaiveboot(subset), is(subset),'o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(truenaiveboot(subset), naive(subset),'o');
set(p2,'LineWidth',1.5);
p3 = plot(truenaiveboot(subset),boot(subset),'o');
set(p3,'LineWidth',1.5);
xlabel('True Xbar')
ylabel('Xbar estimate')
refline(1,0)
pbaspect([1 1 1])
xlim([0,1.6])
ylim([-1,3])
title('Plotting the Estimates against the true values')
legend('Data Splitting','Naive','Bootstrap', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit('Plots/PaperPlots/ComparisonofXbars/topten_estsvsnaive.pdf'), '-transparent')
