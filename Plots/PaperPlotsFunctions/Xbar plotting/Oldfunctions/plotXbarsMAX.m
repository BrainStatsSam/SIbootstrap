function plotXbarsMAX( type, nsubj, trans_level)
% PLOTXBARS( type, nsubj ) plots the Xbar graphs for a certain type and
% number of subjects.
%--------------------------------------------------------------------------
% ARGUMENTS
% type      Either: 'mean', 'tstat' or 'smoothtstat'.
% nsubj     The number of subjects. Default is 20.
% trans_level  Default is 1 which means no transparency. Otherwise the
%           transparency of the individual plots is set to the specified amount.
%--------------------------------------------------------------------------
% OUTPUT
% Generates plots using export_fig.
%--------------------------------------------------------------------------
% EXAMPLES
% PlotXbars( 'mean' )
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 1
    type = 'mean';
end
if nargin < 2
    nsubj = 20;
end
if nargin < 3
    trans_level = 1;
end

str_trans_level = num2str(trans_level);
global def_col

if strcmp(type, 't') || strcmp(type, 'tstat')
    type = 'tstat';
    label_for_y = 'Cohens d';
elseif strcmp(type, 'smootht') || strcmp(type, 'smoothtstat')
    type = 'smoothtstat';
    label_for_y = 'Cohens d';
elseif strcmp(type, 'mean')
    label_for_y = 'Xbar';
else
    error('type must be one of the specified types')
end

if nsubj == 20
    if strcmp(type, 'mean')
        xlims = [-40,140];
        ylims = [-100,250];
        xlims_naive = [60,220];
        ylims_naive = [-100,250];
    elseif strcmp(type, 'tstat')
        xlims = [-0.2, 1.6];
        ylims = [-1,3];
        xlims_naive = [1,3.5];
        ylims_naive = [-1,4];
    elseif strcmp(type, 'smoothtstat')
        xlims = [-0.3,1.7];
        ylims = [-0.7,2.7];
        xlims_naive = [-0.3,2.7];
        ylims_naive = [-0.7,2.7];
    end
    no_of_groups = 247;
elseif nsubj == 50
    if strcmp(type, 'mean')
        xlims = [-40,140];
        ylims = [-100,250];
        xlims_naive = [60,220];
        ylims_naive = [-100,250];
    elseif strcmp(type, 'tstat')
        xlims = [0.2, 1.6];
        ylims = [-0.1, 2.5];
        xlims_naive = [0.9, 2.4];
        ylims_naive = [0, 2.5];
    elseif strcmp(type, 'smoothtstat')
        xlims = [0.3, 1.6];
        ylims = [0.2, 2.3];
        xlims_naive = [0.8, 2.2];
        ylims_naive = [0, 2.2];
    end
    no_of_groups = 98;
end

maxima_subset = 1:20:(floor(4945/nsubj)*20);
nsubj = num2str(nsubj); %So that we can input as a number.

%% Get Data
M = readtable(jgit(strcat('Results/',type,'B50nsubj',nsubj,'Data.csv')));
jgit(strcat('Results/OptimalResults/Optimal_Estimate_', type, 'nsubj', nsubj, '.mat'))
temp = load(jgit(strcat('Results/OptimalResults/Optimal_Estimate_', type, 'nsubj', nsubj, '.mat')));
opt_est = temp.optimal_est;

% M.Properties.VariableNames
M = table2array(M);


naive = M(:,4);
truenaiveboot = M(:,5);
is = M(:,7);
boot = M(:,3);
trueatlocis = M(:,8);


%% Just the maxima. Ests versus Naive.

% maxima_subset = 1:20:(no_of_groups*20); %Just gives the maxima.

clf
p2 = plot(naive(maxima_subset),is(maxima_subset),'o');
set(p2,'LineWidth',1.5);
hold on
p1 = plot(naive(maxima_subset),boot(maxima_subset),'o');
set(p1,'LineWidth',1.5);
p1 = plot(naive(maxima_subset),boot(maxima_subset),'o');
set(p1,'LineWidth',1.5);
xlabel(strcat('Naive ', label_for_y))
ylabel(strcat(label_for_y,' estimate'))
refline(1,0)
% xlim(xlims_naive)
% ylim(ylims_naive)
pbaspect([1 1 1])
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
title('Plotting the Estimates against the Naive values')
legend('Data Splitting', 'Bootstrap', 'Optimal', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/Maxima/', type, 'nsubj', nsubj, 'maxima_estsvsnaive.pdf')), '-transparent')

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
p4 = plot(truenaiveboot(maxima_subset),opt_est(maxima_subset),'o');
set(p4,'LineWidth',1.5);
xlabel('True Xbar')
ylabel(strcat(label_for_y,' estimate'))
refline(1,0)
pbaspect([1 1 1])
% xlim(xlims)
% ylim(ylims)
title('Plotting the Estimates against the true values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
legend('Data Splitting','Naive','Bootstrap', 'Optimal', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/Maxima/', type, 'nsubj', nsubj, 'maxima_estvstruth.pdf')), '-transparent')


end

