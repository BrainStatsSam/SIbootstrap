function plotXbars( type, nsubj, trans_level)
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
circ_size = 1.5/100;

if strcmp(type, 'sexglm')
    type = 'glmsex';
end

if strcmp(type, 't') || strcmp(type, 'tstat')
    type = 'tstat';
    label_for_y = 'Cohens d';
    nct = 1;
elseif strcmp(type, 'smootht') || strcmp(type, 'smoothtstat')
    type = 'smoothtstat';
    label_for_y = 'Cohens d';
    nct = 1;
elseif strcmp(type, 'glmsex')
    label_for_y = 'R^2';
    circ_size = 1.5;
    nct = 0;
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
    else
        xlims = 'mode';
        ylims = 'mode';
        xlims_naive = 'mode';
        ylims_naive = 'mode';
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
    else
        xlims = 'mode';
        ylims = 'mode';
        xlims_naive = 'mode';
        ylims_naive = 'mode';
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
    else
        xlims = 'mode';
        ylims = 'mode';
        xlims_naive = 'mode';
        ylims_naive = 'mode';
    end
end

groupsize = nsubj;
nsubj = num2str(nsubj); %So that we can input as a number.

%% Get Data
M = readtable(jgit(strcat('Results/',type,'B50nsubj',nsubj,'Data.csv')));

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


%% ests versus truth

cla
p1 = plot(trueatlocis, is,'o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(truenaiveboot, naive,'o');
set(p2,'LineWidth',1.5);
p3 = plot(truenaiveboot, boot,'o');
set(p3,'LineWidth',1.5);
xlabel(strcat('True ', label_for_y))
ylabel(strcat(label_for_y,' estimate'))
% abline(0,1,'color',[128,128,128])
pbaspect([1 1 1])
xlim(xlims)
ylim(ylims)
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
title('Plotting the Estimates against the true values')
legend('indepsplit','naive','boot', 'Location','NorthWest')
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'nsubj', nsubj, 'estvstruth_all.pdf')), '-transparent')

%% ests versus truth: indi plots
cla
if trans_level == 1
    plot(trueatlocis,is,'o','LineWidth',1.5, 'color', def_col('blue'));
else
    transplot(trueatlocis,is, circ_size, 0.2, def_col('blue'))
end
pbaspect([1 1 1])
xlim(xlims)
ylim(ylims)
title('Plotting the Estimates against the true values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
legend('Data Splitting', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
if trans_level == 1
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'nsubj', nsubj, 'estvstruth_indi_DS.pdf')), '-transparent')
else
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'TRANS', str_trans_level, 'nsubj', nsubj, 'estvstruth_indi_DS.tif')), '-transparent')
end

cla
if trans_level == 1
    plot(truenaiveboot, naive,'o','LineWidth',1.5, 'color', def_col('red'));
else
    transplot(truenaiveboot, naive, circ_size, 0.2, def_col('red'))
end
pbaspect([1 1 1])
xlim(xlims)
ylim(ylims)
title('Plotting the Estimates against the true values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
legend('Naive', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
if trans_level == 1
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'nsubj', nsubj, 'estvstruth_indi_naive.pdf')), '-transparent')
else
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'TRANS', str_trans_level, 'nsubj', nsubj, 'estvstruth_indi_naive.tif')), '-transparent')
end


cla
if trans_level == 1
    plot(truenaiveboot, boot,'o','LineWidth',1.5, 'color', def_col('yellow'));
else
    transplot(truenaiveboot, boot, circ_size, 0.2, def_col('yellow'))
end
xlabel(strcat('True ', label_for_y))
ylabel(strcat(label_for_y,' estimate'))
% abline(0,1,'color',[128,128,128])
pbaspect([1 1 1])
abline(0,1,'color',[1,1,1]/2,'linestyle', '-')
xlim(xlims)
ylim(ylims)
title('Plotting the Estimates against the true values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
legend('Bootstrap', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
if trans_level == 1
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'nsubj', nsubj, 'estvstruth_indi_boot.pdf')), '-transparent')
else
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'TRANS', str_trans_level, 'nsubj', nsubj, 'estvstruth_indi_boot.tif')), '-transparent')
end

%% All. Ests versus Naive

cla
p2 = plot(naive,is,'o', 'color', def_col('blue'));
set(p2,'LineWidth',1.5);
hold on
p1 = plot(naive,boot,'o', 'color', def_col('yellow'));
set(p1,'LineWidth',1.5);
xlabel(strcat('Naive ', label_for_y))
ylabel(strcat(label_for_y,' estimate'))
rline = refline(1,0);
rline.Color = 'b';
pbaspect([1 1 1])
xlim(xlims_naive)
ylim(ylims_naive)
title('Plotting the Estimates against the Naive values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
legend('Data Splitting', 'Bootstrap', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])
export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'nsubj', nsubj, 'estsvsnaive.pdf')), '-transparent')

end

