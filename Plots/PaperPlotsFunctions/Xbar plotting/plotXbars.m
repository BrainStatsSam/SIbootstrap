function plotXbars( type, groupsize, masktype, thresh, no_axis_limits, nboot )
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
    masktype = '01';
end
if nargin < 4
    thresh = 1;
end
if nargin < 5
    no_axis_limits = 1;
end
if nargin < 6
    nboot = 100;
end

out = prep_Xbar_plots( type, groupsize, thresh, no_axis_limits, masktype, nboot );
type = out.type;
groupsize = num2str(groupsize);
%% ests versus truth
clf
p1 = plot( out.trueatlocis, out.is,'o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot( out.truenaiveboot, out.naive,'o');
set(p2,'LineWidth',1.5);
p3 = plot( out.truenaiveboot, out.boot,'o');
set(p3,'LineWidth',1.5);
xlabel(strcat('True ',  out.label_for_y))
ylabel(strcat( out.label_for_y,' estimate'))
% abline(0,1,'color',[128,128,128])
pbaspect([1 1 1])
xlim(out.xlims)
ylim(out.ylims)
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
title('Plotting the Estimates against the true values')
legend('indepsplit','naive','boot', 'Location','NorthWest')
if thresh
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'Thresh/', groupsize, '/', type, 'nsubj', groupsize, 'estvstruth_all_Thresh.pdf')), '-transparent')
else
    export_fig(jgit(strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', groupsize, '/', type, 'nsubj', groupsize, 'estvstruth_all.pdf')), '-transparent')
end
% export_fig(strcat('/data/fireback/davenpor/davenpor/jalagit/Plots/PaperPlots/ComparisonofXbars/', type,'/', nsubj, '/', type, 'nsubj', nsubj, 'estvstruth_all.pdf'), '-transparent')
end

