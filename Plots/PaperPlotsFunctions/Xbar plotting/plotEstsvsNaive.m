function plotEstsvsNaive( type, groupsize, use_trans, thresh, no_axis_limits, nboot )
% PLOTESTSVSNAIVE( type, groupsize, thresh, no_axis_limits, nboot ) 
% plots the Xbar estimates against their naive versions.
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
% 
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
    nboot = 50;
end
global def_col

out = prep_Xbar_plots( type, groupsize, thresh, no_axis_limits, nboot );


%% Transparent File Naming
type = out.type;
if use_trans
    trans_level = out.trans_level;
else
    trans_level = 1;
end

groupsize_str = num2str(groupsize);
TL_str = num2str(floor(100*trans_level));
nboot = num2str(nboot);

if thresh
    if trans_level ~= 1
        filestart = strcat('Plots/PaperPlots/ComparisonofXbars/tiffImages/', type, 'TRANS', TL_str, 'nsubj', groupsize_str, 'B', nboot);
    else
        filestart = strcat('Plots/PaperPlots/ComparisonofXbars/', type,'Thresh/', groupsize_str, '/', type, 'nsubj', groupsize_str, 'B', nboot);
    end
else
    if trans_level ~= 1
        filestart = strcat('Plots/PaperPlots/ComparisonofXbars/tiffImages/', type, 'TRANS', TL_str, 'nsubj', groupsize_str, 'B', nboot);
    else
        filestart = strcat('Plots/PaperPlots/ComparisonofXbars/', type,'/', groupsize_str, '/', type, 'nsubj', groupsize_str, 'B', nboot);
    end
end

%% All. Ests versus Naive

clf
if use_trans
    transplot(out.naive, out.boot, out.circ_size_naive, trans_level, def_col('yellow'))
    trans_level
    out.circ_size_naive
else
%     p2 = plot( out.naive, out.is,'o', 'color', def_col('blue'));
%     set(p2,'LineWidth',1.5);
%     hold on
    p1 = plot( out.naive, out.boot,'o', 'color', def_col('yellow'));
    set(p1,'LineWidth',1.5);
end
xlabel(strcat('Naive ',  out.label_for_y))
ylabel(strcat( out.label_for_y,' estimate'))
rline = refline(1,0);
rline.Color = 'b';
pbaspect([1 1 1])
xlim( out.xlims_naive)
ylim( out.ylims_naive)
% title('Plotting the Estimates against the Naive values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
legend('Data Splitting', 'Bootstrap', 'Location','NorthWest')
set(gcf, 'position', [500,500,800,800])

if trans_level == 1
    export_fig(jgit(strcat(filestart, 'estsvsnaive.pdf')), '-transparent')
else
    export_fig(jgit(strcat(filestart, 'estsvsnaive.tif')), '-transparent')
%     sn_shot(jgit(strct(filestart, 'estvstruth_indi_DS')))
end

end

