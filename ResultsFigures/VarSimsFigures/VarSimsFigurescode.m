%% Code to generate the variance simulation figures for Reviewer 2
% export_fig is required in order to save the images. 

global def_col %Need to load startup.m for this to work.
global SIbootstrap_loc %Needs to be set via startup.m
if isempty(SIbootstrap_loc) || isempty(def_col)
    error('SIbootstrap_loc and def_col must be defined by running startup.m')
end

nsubj = 50;
K = 0;
pos_vector = [0,550,800,533];

% corresponding_figure = {'S1', '5', '7', 'S2'};
corresponding_figure = {'A'};



% {'mean','tstat', 't4lm', 'R2'};
for type = {'R2', 'tstat'}
    if strcmp(type{1}, 'R2')
        ES_values = 0.05:0.05:0.3;
        x_ax_label = 'Peak partial R^2';
    elseif strcmp(type{1}, 'tstat')
        ES_values = 0.1:0.1:0.7;
        x_ax_label = 'Peak Cohen''s d';
    end
    nentries = length(ES_values);
    
    K = K+1;
    for FWHM = 3
        isbias = zeros(1, nentries);
        isrmse = zeros(1, nentries);
        bootbias = zeros(1, nentries);
        bootrmse = zeros(1, nentries);
        naivebias = zeros(1, nentries);
        naivermse = zeros(1, nentries);
        
        for I = 1:nentries
            try
                out = dispres_sims_thresh(type{1}, nsubj, FWHM, ES_values(I));
%                 out = dispres_sims_thresh(type{1}, subject_list(I), s, FWHM, version, 0 , 0);
                I
                isbias(I) = mean(out.biasis);
%                 ismse(I) = mean(out.mseis);
                isrmse(I) = sqrt(mean(out.mseis));
                naivebias(I) = mean(out.biasnaive);
%                 naivemse(I) = mean(out.msenaive);
                naivermse(I) = sqrt(mean(out.msenaive));
                bootbias(I) = mean(out.biasboot);
                bootrmse(I) = sqrt(mean(out.mseboot));
%                 bootmse(I) = mean(out.mseboot);
            catch 
                isbias(I) = 0;
                isrmse(I) =  0;
                naivebias(I) = 0;
                naivermse(I) = 0;
                bootbias(I) = 0;
                bootrmse(I) = 0;
            end
        end
        
        bootsd = (bootrmse.^2 - bootbias.^2);
        naivesd = (naivermse.^2 - naivebias.^2);
        issd = (isrmse.^2 - isbias.^2);
        
        clf
        plot( ES_values, naivebias, 'linewidth', 2, 'Color', def_col('red'))
        hold on
        plot( ES_values, isbias, 'linewidth', 2,'Color', def_col('blue'))
        plot( ES_values, bootbias, 'linewidth', 2,'Color', def_col('yellow'))
        xlabel(x_ax_label)
        ylabel('Bias')
        xlim([ES_values(1),ES_values(end)])
        title('Bias versus peak effect size')
        %             if groupsize == 20
        legend('Circular', 'Data-Splitting', 'Bootstrap' )
        %             end
        set(gca,'fontsize', 20)
        set(gcf, 'position', pos_vector)
        export_fig([SIbootstrap_loc,'ResultsFigures/VarSimsFigures/', type{1},'_bias'], '-transparent')
        
        clf
        plot( ES_values, naivermse, 'linewidth', 2, 'Color', def_col('red'))
        hold on
        plot( ES_values, isrmse, 'linewidth', 2,'Color', def_col('blue'))
        plot( ES_values, bootrmse, 'linewidth', 2,'Color', def_col('yellow'))
        xlabel(x_ax_label)
        ylabel('RMSE')
        xlim([ES_values(1), ES_values(end)])
        title(['RMSE versus peak effect size'])
%         legend('Circular', 'Data-Splitting', 'Bootstrap' )
        set(gca,'fontsize', 20)
        set(gcf, 'position', pos_vector)
        export_fig([SIbootstrap_loc,'ResultsFigures/VarSimsFigures/', type{1},'_rmse'], '-transparent')
        
        clf
        plot( ES_values, naivesd, 'linewidth', 2, 'Color', def_col('red'))
        hold on
        plot( ES_values, issd, 'linewidth', 2, 'Color', def_col('blue'))
        plot( ES_values, bootsd, 'linewidth', 2,'Color', def_col('yellow'))
        xlabel(x_ax_label)
        ylabel('Standard Deviation')
        xlim([ES_values(1),ES_values(end)])
        title('Standard Deviation versus peak effect size')
%         legend('Circular', 'Data-Splitting', 'Bootstrap' )
        set(gca,'fontsize', 20)
        set(gcf, 'position', pos_vector)
        export_fig([SIbootstrap_loc,'ResultsFigures/VarSimsFigures/', type{1},'_std'], '-transparent')
    end
end