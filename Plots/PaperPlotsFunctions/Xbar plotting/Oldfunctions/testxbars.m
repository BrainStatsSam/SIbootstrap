type = 'mean';
nsubj = '20';

if strcmp(type, 'smoothtstat')
    xlims = [0,1.6];
    ylims = [-1,3];
elseif strcmp(type, 'tstat')
elseif strcmp(type, 'mean')
else
    error('type is not set correctly, it should equal smoothtstat, tstat or mean')
end

M = readtable(jgit(strcat('Results/',type,'B50nsubj',nsubj,'Data.csv')));

% M.Properties.VariableNames
M = table2array(M);


naive = M(:,4);
truenaiveboot = M(:,5);
is = M(:,7);
boot = M(:,3);
trueatlocis = M(:,8);

maxima_subset = 1:20:2000; %Just gives the maxima.

peaksnos = M(:,2);
toptenlocs = find2(peaksnos, 1:10);

%% ests versus truth

cla
p1 = plot(trueatlocis, is,'o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(truenaiveboot, naive,'o');
set(p2,'LineWidth',1.5);
p3 = plot(truenaiveboot, boot,'o');
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
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/type', type, 'nsubj', nsubj, 'estvstruth_all.pdf')), '-transparent')

%% ests versus truth: indi plots
cla
plot(trueatlocis,is,'o','LineWidth',1.5);
pbaspect([1 1 1])
xlim([0,1.6])
ylim([-1,3])
title('Plotting the Estimates against the true values')
legend('Data Splitting', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit('Plots/PaperPlots/ComparisonofXbars/estvstruth_indi_DS.pdf'), '-transparent')

cla
plot(truenaiveboot, naive,'o','LineWidth',1.5, 'color', 'red');
pbaspect([1 1 1])
xlim([0,1.6])
ylim([-1,3])
title('Plotting the Estimates against the true values')
legend('Naive', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/type', type, 'nsubj', nsubj, 'estvstruth_indi_naive.pdf')), '-transparent')


cla
plot(truenaiveboot, boot,'o','LineWidth',1.5, 'color', 'cyan');
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
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/type', type, 'nsubj', nsubj, 'estvstruth_indi_boot.pdf')), '-transparent')

%% Just the maxima ests versus truth
% M = readtable(jgit('Results/tstatB50nsubj20Data.csv'));
cla
p1 = plot(trueatlocis(maxima_subset), is(maxima_subset),'o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(truenaiveboot(maxima_subset), naive(maxima_subset),'o');
set(p2,'LineWidth',1.5);
p3 = plot(truenaiveboot(maxima_subset),boot(maxima_subset),'o');
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
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/type', type, 'nsubj', nsubj, 'maxima_estvstruth.pdf')), '-transparent')

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
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/type', type, 'nsubj', nsubj, 'estsvsnaive.pdf')), '-transparent')

%% Just the maxima. Ests versus Naive.

maxima_subset = 1:20:2000; %Just gives the maxima.


cla
p2 = plot(naive(maxima_subset),is(maxima_subset),'o');
set(p2,'LineWidth',1.5);
hold on
p1 = plot(naive(maxima_subset),boot(maxima_subset),'o');
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
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/type', type, 'nsubj', nsubj, 'maxima_estsvsnaive.pdf')), '-transparent')

%% Topten ests versus truth

cla
p1 = plot(trueatlocis(maxima_subset), is(maxima_subset),'o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(truenaiveboot(maxima_subset), naive(maxima_subset),'o');
set(p2,'LineWidth',1.5);
p3 = plot(truenaiveboot(maxima_subset),boot(maxima_subset),'o');
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
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/type', type, 'nsubj', nsubj, 'topten_estsvsnaive.pdf')), '-transparent')
