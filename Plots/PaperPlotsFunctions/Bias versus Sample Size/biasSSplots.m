type_set = {'mean', 'tstat', 'smoothtstat'};

diff_ylims_valueset = {[0,0.9], [0,3.5], [0,1.2]};
percent_ylims_valueset = {[0,0.45], [0,3.5], [0,1.4]};

diff_ylims = containers.Map( type_set, diff_ylims_valueset );
percent_ylims = containers.Map( type_set, percent_ylims_valueset );


set(0,'defaultAxesFontSize', 20);

width = 700;
for type = type_set
    container = loaddata(strcat('biasSS', type));
    sample_list = cell2mat(keys(container));
    sample_list = sample_list(sample_list >= 10);
    
    n_sample_list = length(sample_list);
    
    diff_meansub_truth = zeros(1, n_sample_list);
    diff_meansub_truth_percent = zeros(1, n_sample_list);
    
    for I = 1:n_sample_list
        cont_at_sample = container(sample_list(I));
        combsub = cont_at_sample(:,1);
        truth = cont_at_sample(:,2);
        
        diff_meansub_truth(I) = mean(combsub  - truth);
        diff_meansub_truth_percent(I) = mean((combsub  - truth)./truth);
    end
    
    %Difference Plots
    if strcmp(type, 'mean')
        plot(sample_list,diff_meansub_truth/100, 'linewidth', 4)
        xlabel('Sample Size'); ylabel('Difference in %Bold');
        xlim([sample_list(1),sample_list(end)])
    else
        plot(sample_list,diff_meansub_truth, 'linewidth', 4)
        xlabel('Sample Size'); ylabel('Difference in Cohen''s d');
        xlim([sample_list(1),sample_list(end)])
    end
    
    ylim(diff_ylims(type{1}))
    set(gcf, 'position', [500,500,width,500])
    %     export_fig(jgit(strcat('Plots/PaperPlots/BiasSSplots/', type, '.pdf')), '-transparent')
    if strcmp(type, 'mean')
        export_fig('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/mean', num2str(width),'.pdf', '-transparent')
    elseif strcmp(type,'tstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/tstat', num2str(width),'.pdf'), '-transparent')
    elseif strcmp(type,'smoothtstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/smoothtstat', num2str(width),'.pdf'), '-transparent')
    end
    
    %Percent Plots
    if strcmp(type, 'mean')
        plot(sample_list,diff_meansub_truth_percent, 'linewidth', 4)
        xlabel('Sample Size'); ylabel('Difference in %Bold as a percentage of the truth');
    else
        plot(sample_list,diff_meansub_truth_percent, 'linewidth', 4)
        xlabel('Sample Size'); ylabel('Difference in Cohen''s d as a percentage of the truth');
    end
    
    ylim(percent_ylims(type{1}))
    set(gcf, 'position', [500,500,width,500])
    if strcmp(type, 'mean')
        %     export_fig(jgit(strcat('Plots/PaperPlots/BiasSSplots/', type, '_percent.pdf')), '-transparent')
        %     export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/', type, '_percent.pdf'), '-transparent')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/mean_percent', num2str(width),'.pdf'), '-transparent')
    elseif strcmp(type,'tstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/tstat_percent', num2str(width),'.pdf'), '-transparent')
    elseif strcmp(type,'smoothtstat')
        export_fig(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/smoothtstat_percent', num2str(width),'.pdf'), '-transparent')
    end
    
end
