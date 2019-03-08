global def_col

type_set = {'tstat'};

diff_ylims_valueset = {[0,0.9], [0,3.5], [0,1.2]};
diff_ylims_valueset = {[0,2.5]};
av_ylims_valueset = {[0,4]};
% percent_ylims_valueset = {[0,0.45], [0,3.5], [0,1.4]};

diff_ylims = containers.Map( type_set, diff_ylims_valueset );
av_ylims = containers.Map( type_set, av_ylims_valueset );


set(0,'defaultAxesFontSize', 20);
truth = imgload('fullmos');
truth_at_max = max(truth(:));

width = 700;
for type = type_set
    container = loaddata(strcat('biasSS', type));
    sample_list = cell2mat(keys(container));
    sample_list = sample_list(sample_list >= 10);
    
    n_sample_list = length(sample_list);
    
    diff_meansub_truth = zeros(1, n_sample_list);
    average_peak_height = zeros(1, n_sample_list);
    errorbar_list = zeros(1, n_sample_list);
    diff_meansub_truth_percent = zeros(1, n_sample_list);
    
    for I = 1:n_sample_list
        cont_at_sample = container(sample_list(I));
        combsub = cont_at_sample(:,1);
        truth = cont_at_sample(:,2);
        
        diff_meansub_truth(I) = mean(combsub) - truth_at_max;
        average_peak_height(I) = mean(combsub);
        LowerAndUpperQuantiles = quantile(combsub, [0.025, 0.975]);
        errorbar_list(I) = LowerAndUpperQuantiles(2) - LowerAndUpperQuantiles(1);
        diff_meansub_truth_percent(I) = mean((combsub  - truth_at_max)./truth_at_max);
    end
    
    %Difference Plots
    if strcmp(type, 'mean')
        plot(sample_list,diff_meansub_truth/100, 'linewidth', 4)
        xlabel('Sample Size'); ylabel('Difference in %Bold');
        xlim([sample_list(1),sample_list(end)])
    else
        plot(sample_list,diff_meansub_truth, 'linewidth', 4)
        xlabel('Sample Size'); ylabel('Difference in Cohen''s d');
        title('Difference realative to the truth')
        xlim([sample_list(1),sample_list(end)])
    end
    
    ylim(diff_ylims(type{1}))
    set(gcf, 'position', [500,500,width,500])
    %     export_fig(jgit(strcat('Plots/PaperPlots/BiasSSplots/', type, '.pdf')), '-transparent')
    if strcmp(type, 'mean')
        export_fig('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/meandiffREL2truth', num2str(width),'.pdf', '-transparent')
    elseif strcmp(type,'tstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/tstatdiffREL2truth', num2str(width),'.pdf'), '-transparent')
    elseif strcmp(type,'smoothtstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/smoothtstatdiffREL2truth', num2str(width),'.pdf'), '-transparent')
    end
    
    %Average Compared to Actual Plots
    cla
    if strcmp(type, 'tstat')
        plot(sample_list,average_peak_height, 'linewidth', 4)
        hold on
        plot(sample_list, repmat(truth_at_max, 1, length(sample_list)), 'linewidth', 4);
        legend('Average Max Peak Height', 'True Max Peak Height', 'Location','NorthEast')
        xlabel('Sample Size'); ylabel('Cohen''s d');
        title('Average Relative to Truth')
        xlim([sample_list(1),sample_list(end)])
    end
    
    ylim(av_ylims(type{1}))
    set(gcf, 'position', [500,500,width,500])
    %     export_fig(jgit(strcat('Plots/PaperPlots/BiasSSplots/', type, '.pdf')), '-transparent')
    if strcmp(type, 'mean')
        export_fig('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/meanREL2truth', num2str(width),'.pdf', '-transparent')
    elseif strcmp(type,'tstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/tstatREL2truth', num2str(width),'.pdf'), '-transparent')
    elseif strcmp(type,'smoothtstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/smoothtstatREL2truth', num2str(width),'.pdf'), '-transparent')
    end
    
    %Plot with error bars
    cla
    if strcmp(type, 'tstat')
        line1 = plot(sample_list,average_peak_height, 'linewidth', 4);
        hold on
        errorbar(sample_list,average_peak_height, errorbar_list, 'linewidth', 2, 'color', def_col('blue'));
        hold on
        line2 = plot(sample_list, repmat(truth_at_max, 1, length(sample_list)), 'linewidth', 4);
        legend([line1,line2],'Average Max Peak Height', 'True Max Peak Height', 'Location','NorthEast')
        xlabel('Sample Size'); ylabel('Cohen''s d');
        title('Average Relative to Truth')
        xlim([sample_list(1),sample_list(end)])
    end
    
    ylim(av_ylims(type{1}))
    set(gcf, 'position', [500,500,width,500])
    %     export_fig(jgit(strcat('Plots/PaperPlots/BiasSSplots/', type, '.pdf')), '-transparent')
    if strcmp(type, 'mean')
        export_fig('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/meanREL2truthERRORBAR', num2str(width),'.pdf', '-transparent')
    elseif strcmp(type,'tstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/tstatREL2truthERRORBAR', num2str(width),'.pdf'), '-transparent')
    elseif strcmp(type,'smoothtstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/smoothtstatREL2truthERRORBAR', num2str(width),'.pdf'), '-transparent')
    end
    
end
