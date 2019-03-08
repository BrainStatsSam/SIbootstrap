function boxplots_boot( type, version )
% BOXPLOTS generates the boxplots for the bootstrapping paper.
%--------------------------------------------------------------------------
% ARGUMENTS
% TYPE
% VERSION       Either 'bias', 'mse' or 'var';
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% 
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 2
    version = 'bias';
end
if ~strcmp(version, 'bias')
    error('I think mse and variance are deprecated')
end
masktype = 0;
if strcmp(type, 'vbmagesext')
   masktype = '001'; 
end
if ~strcmp(type, 'tstat') && ~strcmp(type, 'mean') && ~strcmp(type, 't4lm') && ~strcmp(type, 'vbmage') && ~strcmp(type, 'vbmagesext')
    error('This type is not available')
end
if ~strcmp(version, 'bias') && ~strcmp(version, 'mse') && ~strcmp(version, 'MSE') && ~strcmp(version, 'var')
    error('This version is not available')
end

if strcmp(version, 'var')
    error('This may not exist or not be defined in our setting as have an mse and a bias for each peak estimate in each realization')
end

if strcmp(version, 'mse')
    version = upper(version);
end

set(0,'defaultAxesFontSize', 16);
set(gcf, 'position', [0,550,1500,600])

if strcmp(type, 'vbmagesext')
    out20 = dispres_thresh(type, 50, masktype, 0 );
    out50 = dispres_thresh(type, 100, masktype, 0 );
    out100 = dispres_thresh(type, 200, masktype, 0 );
% else strcmp(type, 'vbmagesext')
%     out20 = dispres_thresh(type, 50, masktype, 0 );
%     out50 = dispres_thresh(type, 100, masktype, 0 );
%     out100 = dispres_thresh(type, 200, masktype, 0 );
% else
    naive20 = out20.(strcat(version,'naive'))';
    naive50 = out50.(strcat(version,'naive'))';
    naive100 = out100.(strcat(version,'naive'))';
    is20 = out20.(strcat(version,'is'))';
    is50 = out50.(strcat(version,'is'))';
    is100 = out100.(strcat(version,'is'))';
    boot20 = out20.(strcat(version,'boot'))';
    boot50 = out50.(strcat(version,'boot'))';
    boot100 = out100.(strcat(version,'boot'))';
elseif strcmp(type, 'tstat')
    out20 = dispres_thresh(type, 20, masktype, 0 );
    out50 = dispres_thresh(type, 50, masktype, 0 );
    out100 = dispres_thresh(type, 100, masktype, 0 );
    
    naive20 = out20.(strcat(version,'naive'))';
    naive50 = out50.(strcat(version,'naive'))';
    naive100 = out100.(strcat(version,'naive'))';
    is20 = out20.(strcat(version,'is'))';
    is50 = out50.(strcat(version,'is'))';
    is100 = out100.(strcat(version,'is'))';
    boot20 = out20.(strcat(version,'boot'))';
    boot50 = out50.(strcat(version,'boot'))';
    boot100 = out100.(strcat(version,'boot'))';
elseif strcmp(type, 'mean')  || strcmp(type, 't4lm')
    out20 = dispres_thresh(type, 20, masktype, 0 );
    out50 = dispres_thresh(type, 50, masktype, 0 );
    out100 = dispres_thresh(type, 100, masktype, 0 );
    
    naive20 = out20.(strcat(version,'naive'))'/100;
    naive50 = out50.(strcat(version,'naive'))'/100;
    naive100 = out100.(strcat(version,'naive'))'/100;
    is20 = out20.(strcat(version,'is'))'/100;
    is50 = out50.(strcat(version,'is'))'/100;
    is100 = out100.(strcat(version,'is'))'/100;
    boot20 = out20.(strcat(version,'boot'))'/100;
    boot50 = out50.(strcat(version,'boot'))'/100;
    boot100 = out100.(strcat(version,'boot'))'/100;
end


group_vector = repelem(1:9, [length(naive20), length(is20), length(boot20), length(naive50), length(is50), length(boot50), length(naive100), length(is100), length(boot100)]);

data = [naive20, is20, boot20, naive50, is50, boot50, naive100, is100, boot100 ];
boxplot_mod(data, group_vector, 'symbol', '');

set(gca,'xticklabel',{'Circular','Data-Splitting','Bootstrap','Circular','Data-Splitting','Bootstrap','Circular','Data-Splitting','Bootstrap'})

if strcmp(type, 'tstat')
   vert_placement = -0.77;
elseif strcmp(type, 't4lm')
    vert_placement = -19.5/100;
elseif strcmp(type, 'mean')
    vert_placement = -50.5/100;
end

if strcmp(type, 'vbmagesext')
    text(1.67,-0.157, 'N = 50', 'FontSize', 20)
    text(1.67+2.9,-0.157, 'N = 100', 'FontSize', 20)
    text(1.67+5.9,-0.157, 'N = 200', 'FontSize', 20)
else
    text(1.67,vert_placement, 'N = 20', 'FontSize', 20)
    text(1.67+3,vert_placement, 'N = 50', 'FontSize', 20)
    text(1.67+5.9,vert_placement, 'N = 100', 'FontSize', 20)
end
abline('v',3.5, 'LineStyle', '-', 'color', 'black') 
abline('v',6.5, 'LineStyle', '-', 'color', 'black') 
abline('h', 0)
title(['Comparing the ', version,' over the significant peaks'],'FontSize', 25, 'FontWeight', 'normal')

%Plot the mean:
hold on
plot(1, mean(naive20(~isnan(naive20))), 'o', 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black' )
plot(4, mean(naive50), 'o', 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black' )
plot(7, mean(naive100), 'o', 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black' )

plot(3, mean(boot20(~isnan(boot20))), 'o', 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black' )
plot(6, mean(boot50), 'o', 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black' )
plot(9, mean(boot100), 'o', 'MarkerFaceColor','black', 'MarkerEdgeColor', 'black' )

plot(2, mean(is20(~isnan(is20))), 'o', 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black' )
plot(5, mean(is50), 'o', 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black' )
plot(8, mean(is100), 'o', 'MarkerFaceColor', 'black', 'MarkerEdgeColor', 'black' )

% title(['\fontsize{25}Comparing the ', version,' over the significant peaks'],'FontSize', 25)

% ymin = min([quantile(naive20, 0.05), quantile(is20, 0.05), quantile(boot20, 0.05)]);
% ymax = max([quantile(naive20, 0.95), quantile(is20, 0.95), quantile(boot20, 0.95)]);

if strcmp(version, 'bias')
    lower_quantile = 0.1;
    upper_quantile = 0.9;
    
    ymin = min([quantile(naive20, lower_quantile), quantile(is20, lower_quantile), quantile(boot20, lower_quantile),quantile(naive50, lower_quantile), quantile(is50, lower_quantile), quantile(boot50, lower_quantile), quantile(naive100, lower_quantile), quantile(is100, lower_quantile), quantile(boot100, lower_quantile)]);
    ymax = max([quantile(naive20, upper_quantile), quantile(is20, upper_quantile), quantile(boot20, upper_quantile),quantile(naive50, upper_quantile), quantile(is50, upper_quantile), quantile(boot50, upper_quantile), quantile(naive100, upper_quantile), quantile(is100, upper_quantile), quantile(boot100, upper_quantile)]);
elseif strcmp(version, 'MSE')
    upper_quantile = 0.8;
    ymax = max([quantile(naive20, upper_quantile), quantile(is20, upper_quantile), quantile(boot20, upper_quantile),quantile(naive50, upper_quantile), quantile(is50, upper_quantile), quantile(boot50, upper_quantile), quantile(naive100, upper_quantile), quantile(is100, upper_quantile), quantile(boot100, upper_quantile)]);
    
    if strcmp(type, 'tstat')
        ymin = -0.1;
    elseif  strcmp(type, 'mean')
        ymin = -100;
    elseif strcmp(type, 't4lm')
        ymin = -50;
        ymax = 500;
    else
        error('Not set yet')
    end
elseif strcmp(version, 'var')
    lower_quantile = 0.1;
    upper_quantile = 0.9;
    
    ymin = min([quantile(naive20, lower_quantile), quantile(is20, lower_quantile), quantile(boot20, lower_quantile),quantile(naive50, lower_quantile), quantile(is50, lower_quantile), quantile(boot50, lower_quantile), quantile(naive100, lower_quantile), quantile(is100, lower_quantile), quantile(boot100, lower_quantile)]);
    ymax = max([quantile(naive20, upper_quantile), quantile(is20, upper_quantile), quantile(boot20, upper_quantile),quantile(naive50, upper_quantile), quantile(is50, upper_quantile), quantile(boot50, upper_quantile), quantile(naive100, upper_quantile), quantile(is100, upper_quantile), quantile(boot100, upper_quantile)]);
end
ylim([ymin, ymax])

if ~strcmp(version, 'MSE') && ~strcmp(version, 'mse')
    label_for_y_axis = capstr(version);
else
    label_for_y_axis = version;
end
if strcmp(version, 'bias')
    if strcmp(type, 'tstat')
        label_for_y_axis = [label_for_y_axis, ' in Cohen''s d'];
    elseif strcmp(type, 'vbmage')
        label_for_y_axis = [label_for_y_axis, ' in R^2'];
    elseif strcmp(type, 't4lm') || strcmp(type, 'mean')
        label_for_y_axis = [label_for_y_axis, ' in %BOLD'];
    end
end

ylabel(label_for_y_axis, 'FontSize', 20)
h = gca;
h.XRuler.TickLength = 0;
export_fig(jgit(strcat('Plots/PaperPlots/Boxplots/', type,'_',version, '_thresh.pdf')), '-transparent')

end

