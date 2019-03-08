function plotOptXbars( type, nsubj, trans_level)
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
% plotOptXbars( 'mean' )
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
circ_size = 1.5/100;

if strcmp(type, 't') || strcmp(type, 'tstat')
    type = 'tstat';
    label_for_y = 'Cohens d';
    nct = 1;
elseif strcmp(type, 'smootht') || strcmp(type, 'smoothtstat')
    type = 'smoothtstat';
    label_for_y = 'Cohens d';
    nct = 1;
elseif strcmp(type, 'mean') || strcmp(type, 'SSmean')
    label_for_y = 'Xbar';
    circ_size = 1.5;
    nct = 0;
else
    error('type must be one of the specified types')
end

if nsubj == 20
    if strcmp(type, 'mean') || strcmp(type, 'SSmean')
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
elseif nsubj == 50
    if strcmp(type, 'mean') || strcmp(type, 'SSmean')
        xlims = [0,140];
        ylims = [-50,200];
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
elseif nsubj == 100
    if strcmp(type, 'mean') || strcmp(type, 'SSmean')
        xlims = [0,140];
        ylims = [-50,200];
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
end

groupsize = nsubj;
nsubj = num2str(nsubj); %So that we can input as a number.

%% Get Data
M = readtable(jgit(strcat('Results/',type,'B50nsubj',nsubj,'Data.csv')));
temp = load(jgit(strcat('Results/OptimalResults/Optimal_Estimate_', type, 'nsubj', nsubj, '.mat')));
opt_est = temp.optimal_est;
% M.Properties.VariableNames
M = table2array(M);

truenaiveboot = M(:,5);
boot = M(:,3);
trueatlocis = M(:,8);

if nct == 1
    naive = M(:,4)/nctcorrection(groupsize); %correcting for non-central t
    is = M(:,7)/nctcorrection(groupsize/2);
else
    naive = M(:,4); %correcting for non-central t
    is = M(:,7);
end


%% ests versus truth: indi plots
cla
if trans_level == 1
    plot(truenaiveboot,opt_est,'o','LineWidth',1.5, 'color', def_col('purple'));
else
    transplot(truenaiveboot,opt_est, circ_size, 0.2, def_col('purple'))
end
pbaspect([1 1 1])
xlim(xlims)
ylim(ylims)
title('Plotting the Estimates against the true values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
legend('Optimal Estimate', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
if trans_level == 1
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'nsubj', nsubj, 'estvstruth_indi_opt.pdf')), '-transparent')
else
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'TRANS', str_trans_level, 'nsubj', nsubj, 'estvstruth_indi_opt.tif')), '-transparent')
end

end

