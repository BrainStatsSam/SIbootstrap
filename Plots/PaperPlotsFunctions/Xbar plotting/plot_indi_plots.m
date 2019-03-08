function plot_indi_plots( type, groupsize, use_trans, thresh, no_axis_limits, use_rft, masktype, nboot )
% PLOT_INDI_PLOTS( type, groupsize, trans_level, thresh, no_axis_limits, nboot )
% makes individual and transparent plots.
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
% plotXbars( 'mean' )
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 1
    type = 'mean';
end
if nargin < 2
    groupsize = 20;
end
if nargin < 3
    use_trans = 1;
end
if nargin < 4
    thresh = 1;
end
if nargin < 5
    no_axis_limits = 1;
end
if nargin < 6
    use_rft = 0;
end
if nargin < 7
     masktype = '01';
end
if nargin < 8
    nboot = 100;
end

global def_col

out = prep_Xbar_plots( type, groupsize, thresh, no_axis_limits, use_rft, masktype, nboot );
type = out.type;
circ_size = out.circ_size;
if use_trans
    trans_level = out.trans_level;
else
    trans_level = 1;
end
B = num2str(nboot);

groupsize_str = num2str(groupsize);
TL_str = num2str(floor(100*trans_level));

if thresh
    if trans_level ~= 1
        filestart = strcat('Plots/PaperPlots/ComparisonofXbars/tiffImages/', type, 'TRANS', TL_str, 'nsubj', groupsize_str, 'B', B);
    else
        filestart = strcat('Plots/PaperPlots/ComparisonofXbars/', type,'Thresh/', groupsize_str, '/', type, 'nsubj', groupsize_str, 'B', B);
    end
else
    if trans_level ~= 1
        filestart = strcat('Plots/PaperPlots/ComparisonofXbars/tiffImages/', type, 'TRANS', TL_str, 'nsubj', groupsize_str, 'B', B);
    else
        filestart = strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', groupsize_str, '/', type, 'nsubj', groupsize_str, 'B', B);
    end
end

if ~use_rft
    filestart = [filestart, '_noRFT'];
end

%% ests versus truth: indi plots
axis_font_size = 25;
filestart

clf
if use_trans == 0
    plot(out.truenaiveboot, out.naive,'o','LineWidth',1.5, 'color', def_col('red'));
else
    transplot(out.truenaiveboot, out.naive, circ_size, trans_level, def_col('red'))
end
% pbaspect([1 1 1])
xlabel(['True',' ', out.label_for_x])
ylabel(['Estimate of ',out.label_for_y])
xlim(out.xlims)
ylim(out.ylims)
set(0,'defaultAxesFontSize', axis_font_size);
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
% legend('Circular', 'Location','NorthWest')
title(['N = ', groupsize_str,': Circular'])
set(gcf, 'position', [500,500,out.height, out.width])
out.xtick
set(gca, 'XTick',out.xtick)
if trans_level == 1
    export_fig(jgit(strcat(filestart, 'estvstruth_indi_naive.pdf')), '-transparent')
else
    export_fig(jgit(strcat(filestart, 'estvstruth_indi_naive.tif')), '-transparent')
%     sn_shot(jgit(strcat(filestart, 'estvstruth_indi_naive')))
end

clf
if use_trans == 0
    plot(out.truenaiveboot, out.boot,'o','LineWidth',1.5, 'color', def_col('yellow'));
else
    transplot(out.truenaiveboot, out.boot, circ_size, trans_level, def_col('yellow'))
end
xlabel(['True',' ', out.label_for_x])
ylabel(['Estimate of ',out.label_for_y])
% abline(0,1,'color',[128,128,128])
% pbaspect([1 1 1])
abline(0,1,'color',[1,1,1]/2,'linestyle', '-')
xlim(out.xlims)
ylim(out.ylims)
set(0,'defaultAxesFontSize', axis_font_size);
% title('Plotting the Estimates against the true values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
% legend('Bootstrap', 'Location','NorthWest')
title(['N = ', groupsize_str,': Bootstrap'])
set(gcf, 'position', [500,500,out.height, out.width])
set(gca, 'XTick',out.xtick)
if trans_level == 1
    export_fig(jgit(strcat(filestart, 'estvstruth_indi_boot.pdf')), '-transparent')
else
    export_fig(jgit(strcat(filestart, 'estvstruth_indi_boot.tif')), '-transparent')
%     sn_shot(jgit(strcat(filestart, 'estvstruth_indi_boot')))
end

clf
if groupsize == 20 && (strcmp(type, 't4lm') || strcmp(type, 'tstat'))
    trans_level = 0.6;
end

if use_trans == 0
    plot(out.trueatlocis,out.is,'o','LineWidth',1.5, 'color', def_col('blue'));
else
    transplot(out.trueatlocis,out.is, circ_size, trans_level, def_col('blue'))
end
% pbaspect([1 1 1])
xlim(out.xlims)
ylim(out.ylims)
set(0,'defaultAxesFontSize', axis_font_size);
xlabel(['True',' ', out.label_for_x])
ylabel(['Estimate of ',out.label_for_y])
% title('Plotting the Estimates against the true values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
% legend('Data-Splitting', 'Location','NorthWest')
title(['N = ', groupsize_str,': Data-Splitting'])
set(gcf, 'position', [500,500,out.height,out.width])
set(gca, 'XTick',out.xtick)
if trans_level == 1
    export_fig(jgit(strcat(filestart, 'estvstruth_indi_DS.pdf')), '-transparent')
else
    export_fig(jgit(strcat(filestart, 'estvstruth_indi_DS.tif')), '-transparent')
%     sn_shot(jgit(strct(filestart, 'estvstruth_indi_DS')))
    print(gcf, '-dpdf', './test.pdf');
end

end

