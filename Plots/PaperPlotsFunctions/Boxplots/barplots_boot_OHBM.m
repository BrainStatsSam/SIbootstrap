%%
type = 'tstat';
pos_vector = [0,550,800,600];
mse_plots = zeros(2,3);
var_plots = zeros(2,3);
bias_plots = zeros(2,3);
nsubj = [50, 100];

for I = 1:2
    out = dispres_thresh(type, nsubj(I));
    mse_plots(I, 1) = mean(out.MSEnaive(~isnan(out.MSEnaive)));
    mse_plots(I, 2) = mean(out.MSEis(~isnan(out.MSEis)));
    mse_plots(I, 3) = mean(out.MSEboot(~isnan(out.MSEboot)));
    
    var_plots(I, 1) = mean(out.MSEnaive(~isnan(out.MSEnaive))) - mean(out.biasnaive(~isnan(out.biasnaive)))^2;
    var_plots(I, 2) = mean(out.MSEis(~isnan(out.MSEis))) - mean(out.biasis(~isnan(out.biasis)))^2;
    var_plots(I, 3) = mean(out.MSEboot(~isnan(out.MSEboot))) - mean(out.biasboot(~isnan(out.biasboot)))^2;
    
    bias_plots(I,1) = mean(out.biasnaive(~isnan(out.biasnaive)));
    bias_plots(I,2) = mean(out.biasis(~isnan(out.biasis)));
    bias_plots(I,3) = mean(out.biasboot(~isnan(out.biasboot)));
end

%%
set(0,'defaultAxesFontSize', 20);
bar_mse_plot = bar(mse_plots, 'FaceColor', def_col('blue'));
bar_mse_plot(1).FaceColor = def_col('red');
bar_mse_plot(3).FaceColor = def_col('yellow');
% xlim([0.35,3.65])
ylim([0,0.15])

legend('Circular', 'Data-Splitting', 'Bootstrap')
% set(gca, 'XTicks',[1, 2, 3])
ylabel('MSE of Cohen''s d estimates', 'FontSize', 20)
title('Comparing the MSE','FontSize', 20, 'FontWeight', 'normal')
set(gca, 'XTickLabel', {'N = 50', 'N = 100'})
set(gcf, 'position', pos_vector)
% abline('v',1.5, 'LineStyle', '-', 'color', 'black') 
% abline('v',2.5, 'LineStyle', '-', 'color', 'black') 
export_fig(jgit(strcat('Plots/PaperPlots/Barplots_OHBM/', type,'MSE.pdf')), '-transparent')
%%
set(0,'defaultAxesFontSize', 20);
bar_var_plot = bar(var_plots, 'FaceColor', def_col('blue'));
bar_var_plot(1).FaceColor = def_col('red');
bar_var_plot(3).FaceColor = def_col('yellow');

legend('Circular', 'Data-Splitting', 'Bootstrap')
% xlim([0.35,3.65])
ylabel('Variance of Cohen''s d estimates', 'FontSize', 20)
title('Comparing the variance','FontSize', 20, 'FontWeight', 'normal')
set(gca, 'XTickLabel', {'N = 50', 'N = 100'})
set(gcf, 'position', pos_vector)
export_fig(jgit(strcat('Plots/PaperPlots/Barplots_OHBM/', type,'VAR.pdf')), '-transparent')

%%
set(0,'defaultAxesFontSize', 20);
bar_bias_plot = bar(bias_plots, 'FaceColor', def_col('blue'));
bar_bias_plot(1).FaceColor = def_col('red');
bar_bias_plot(3).FaceColor = def_col('yellow');

legend('Circular', 'Data-Splitting', 'Bootstrap')
% xlim([0.35,3.65])
ylim([-0.01, 0.32])
ylabel('Bias in Cohen''s d', 'FontSize', 20)
% title('Comparing the average bias of the methods across significant peaks','FontSize', 35, 'FontWeight', 'normal')
title('Comparing the average bias','FontSize', 20, 'FontWeight', 'normal')
set(gca, 'XTickLabel', {'N = 50', 'N = 100'})
set(gcf, 'position', pos_vector)
export_fig(jgit(strcat('Plots/PaperPlots/Barplots_OHBM/', type,'BIAS.pdf')), '-transparent')

%%
type = 'vbmagesexR2';
pos_vector = [0,550,800,600];

mse_plots = zeros(2,3);
var_plots = zeros(2,3);
bias_plots = zeros(2,3);
nsubj = [100, 150];

for I = 1:length(nsubj)
    out = dispres_thresh(type, nsubj(I), '001');
    mse_plots(I, 1) = mean(out.MSEnaive(~isnan(out.MSEnaive)));
    mse_plots(I, 2) = mean(out.MSEis(~isnan(out.MSEis)));
    mse_plots(I, 3) = mean(out.MSEboot(~isnan(out.MSEboot)));
    
    var_plots(I, 1) = mean(out.MSEnaive(~isnan(out.MSEnaive))) - mean(out.biasnaive(~isnan(out.biasnaive)))^2;
    var_plots(I, 2) = mean(out.MSEis(~isnan(out.MSEis))) - mean(out.biasis(~isnan(out.biasis)))^2;
    var_plots(I, 3) = mean(out.MSEboot(~isnan(out.MSEboot))) - mean(out.biasboot(~isnan(out.biasboot)))^2;
    
    bias_plots(I,1) = mean(out.biasnaive(~isnan(out.biasnaive)));
    bias_plots(I,2) = mean(out.biasis(~isnan(out.biasis)));
    bias_plots(I,3) = mean(out.biasboot(~isnan(out.biasboot)));
end

%%
% set(0,'defaultAxesFontSize', 16);
set(0,'defaultAxesFontSize', 20);
bar_mse_plot = bar(mse_plots, 'FaceColor', def_col('blue'));
bar_mse_plot(1).FaceColor = def_col('red');
bar_mse_plot(3).FaceColor = def_col('yellow');
ylim([0,0.03])

legend('Circular', 'Data-Splitting', 'Bootstrap')
% set(gca, 'XTicks',[1, 2, 3])
ylabel('MSE of R^2', 'FontSize', 20)
title('Comparing the MSE', 'FontSize', 20, 'FontWeight', 'normal')
set(gca, 'XTickLabel', {'N = 100', 'N = 150'})
set(gcf, 'position', pos_vector)
export_fig(jgit(strcat('Plots/PaperPlots/Barplots_OHBM/', type,'MSE.pdf')), '-transparent')

%%
set(0,'defaultAxesFontSize', 18);
bar_var_plot = bar(var_plots, 'FaceColor', def_col('blue'));
bar_var_plot(1).FaceColor = def_col('red');
bar_var_plot(3).FaceColor = def_col('yellow');


legend('Circular', 'Data-Splitting', 'Bootstrap')
% xlim([0.35,3.65])
ylim([-0.01, 0.17])
ylabel('Variance of R^2', 'FontSize', 20)
title('Comparing the variance','FontSize', 20, 'FontWeight', 'normal')
set(gca, 'XTickLabel', {'N = 100', 'N = 150'})
set(gcf, 'position', pos_vector)
export_fig(jgit(strcat('Plots/PaperPlots/Barplots_OHBM/', type,'VAR.pdf')), '-transparent')

%%
set(0,'defaultAxesFontSize', 20);
bar_bias_plot = bar(bias_plots, 'FaceColor', def_col('blue'));
bar_bias_plot(1).FaceColor = def_col('red');
bar_bias_plot(3).FaceColor = def_col('yellow');

legend('Circular', 'Data-Splitting', 'Bootstrap')
% xlim([0.35,3.65])
ylim([-0.01, 0.17])
ylabel('Bias in R^2', 'FontSize', 20)
title('Comparing the average bias','FontSize', 20, 'FontWeight', 'normal')
% set(gca, 'XTickLabel', {'N = 20', 'N = 50', 'N = 100'})
set(gca, 'XTickLabel', {'N = 100', 'N = 150'})
set(gcf, 'position', pos_vector)
export_fig(jgit(strcat('Plots/PaperPlots/Barplots_OHBM/', type,'BIAS.pdf')), '-transparent')
