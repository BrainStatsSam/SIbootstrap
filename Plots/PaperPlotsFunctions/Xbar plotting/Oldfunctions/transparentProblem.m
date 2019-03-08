type = 'tstat';
nsubj = 20;
trans_level = 0.5;
str_trans_level = num2str(trans_level);

circ_size = 1.5/100;
if nsubj == 20
    if strcmp(type, 'mean') || strcmp(type, 'SSmean')
        xlims = [-40,140];
        ylims = [-100,250];
        xlims_naive = [60,220];
        ylims_naive = [-100,250];
        circ_size = 1.5;
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
        xlims = [-40,140];
        ylims = [-100,250];
        xlims_naive = [60,220];
        ylims_naive = [-100,250];
        circ_size = 1.5;
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

nsubj = num2str(nsubj); 

if strcmp(type, 't') || strcmp(type, 'tstat')
    type = 'tstat';
    label_for_y = 'Cohens d';
elseif strcmp(type, 'smootht') || strcmp(type, 'smoothtstat')
    type = 'smoothtstat';
    label_for_y = 'Cohens d';
elseif strcmp(type, 'mean') || strcmp(type, 'SSmean')
    label_for_y = 'Xbar';
else
    error('type must be one of the specified types')
end

%%

M = readtable(jgit(strcat('Results/',type,'B50nsubj',nsubj,'Data.csv')));

% M.Properties.VariableNames
M = table2array(M);


naive = M(:,4);
truenaiveboot = M(:,5);
is = M(:,7);
boot = M(:,3);
trueatlocis = M(:,8);

%%


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
% if trans_level == 1
%     export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', type, 'nsubj', nsubj, 'estvstruth_indi_DS.pdf')), '-transparent')
% else
%     export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', type, 'TRANS', str_trans_level, 'nsubj', nsubj, 'estvstruth_indi_DS.tif')), '-transparent')
% end

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
% if trans_level == 1
%     export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', type, 'nsubj', nsubj, 'estvstruth_indi_naive.pdf')), '-transparent')
% else
%     export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', type, 'TRANS', str_trans_level, 'nsubj', nsubj, 'estvstruth_indi_naive.tif')), '-transparent')
% end


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
% if trans_level == 1
%     export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', type, 'nsubj', nsubj, 'estvstruth_indi_boot.pdf')), '-transparent')
% else
%     export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', type, 'TRANS', str_trans_level, 'nsubj', nsubj, 'estvstruth_indi_boot.tif')), '-transparent')
% end
