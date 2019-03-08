group_sizes = 5:5:100;
global stdsize

mean_percent_differences = zeros(1, length(group_sizes));

true_mean = imgload('fullmean');

MNImask = imgload('MNImask');

for I = 1:length(group_sizes)
    nsubj = group_sizes(I);
    for iter = 1:floor(4900/nsubj)
        fprintf(strcat(num2str(I),':',num2str(iter),'\n'));
        mean_ofsubs = zeros(stdsize);
        mask = zeros(stdsize);
        for n = 1:nsubj
            mean_ofsubs = mean_ofsubs + readimg((iter-1)*nsubj + n);
        end
        for n = 1:nsubj
            mask = mask + readimg((iter-1)*nsubj + n, 'mask');
        end
        mask = (mask == nsubj).*MNImask;
        
        mean_ofsubs = mean_ofsubs/nsubj;
        max_mean_index = lmindices(mean_ofsubs, 1, mask);
        mean_percent_differences(I) = mean_percent_differences(I) + (mean_ofsubs(max_mean_index) - true_mean(max_mean_index))/true_mean(max_mean_index);
        %Could do the abs version:
%         mean_percent_differences(I) = mean_percent_differences(I) + abs(mean_ofsubs(max_mean_index) - true_mean(max_mean_index))/true_mean(max_mean_index);
    end
    
    mean_percent_differences(I) = mean_percent_differences(I)/iter;
end

plot(group_sizes, mean_percent_differences, 'linewidth', 2);

header = sprintf('%g,', group_sizes);
header = header(1:length(header)-1);

writecsv(mean_percent_differences, 2, header, jgit('Plots/PaperPlots'), 'differencesvssamplesizepercent.txt')

%%

data = loaddata('biasVSgroupsize_percent');
plot(5:5:100,data, 'linewidth', 2)
xlabel('Sample Size'); ylabel('Difference as a percentage');

%%
set(gcf, 'position', [500,500,600,500])
export_fig(jgit('Plots/PaperPlots/biasVSgroupsize_differencepercent.pdf'), '-transparent')

