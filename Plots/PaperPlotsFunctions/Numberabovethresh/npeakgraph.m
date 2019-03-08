type = 'tstat';
temp = load(strcat(jgit('Plots/PaperPlots/Numberabovethresh/'), type, '_peaknumbers.mat'));
nstore = temp.nstore;

% for type2 = {'npeaks', 'ncomps', 'nabovethresh'}
%     plot(cell2mat(keys(nstore.(type2{1}))), cell2mat(values(nstore.(type2{1}))))
%     pause
% end

%% npeaks
type2 = 'npeaks';
groupsizes = cell2mat(keys(nstore.(type2)));
ngroups = floor(4945./groupsizes);
yax =  cell2mat(values(nstore.(type2)))./double(ngroups);
plot(groupsizes, yax, 'LineWidth', 2)
hold on
plot(2*groupsizes, yax, 'LineWidth', 2)
legend('Circular/Bootstrap', 'Data-Splitting', 'Location','northwest')
xlim([10,100])
set(gca, 'XTick', 10:10:100)
xlabel('N: Sample Size')
ylabel('Average number of peaks per group of size N')
title('Average Number of Significant Peaks')
set(gcf, 'position', [0,550,1000,1000])
export_fig(jgit(strcat('Plots/PaperPlots/Numberabovethresh/', type,'_',type2,'.pdf')), '-transparent')

%% ncomps
clf
type2 = 'ncomps';
groupsizes = cell2mat(keys(nstore.(type2)));
ngroups = floor(4945./groupsizes);
yax =  cell2mat(values(nstore.(type2)))./double(ngroups);
plot(groupsizes, yax, 'LineWidth', 2)
hold on
plot(2*groupsizes, yax, 'LineWidth', 2)
legend('Circular/Bootstrap', 'Data-Splitting', 'Location','northwest')
set(gca, 'XTick', 10:10:100)
xlabel('N: Sample Size')
ylabel('Average number of components per group of size N')
title('Average Number of Significant Components')
set(gcf, 'position', [0,550,1000,1000])
xlim([10,100])
export_fig(jgit(strcat('Plots/PaperPlots/Numberabovethresh/', type,'_',type2,'.pdf')), '-transparent')


%% nabovethresh
clf
type2 = 'nabovethresh';
groupsizes = cell2mat(keys(nstore.(type2)));
ngroups = floor(4945./groupsizes);
yax =  cell2mat(values(nstore.(type2)))./double(ngroups);
plot(groupsizes, yax, 'LineWidth', 2)
hold on
plot(2*groupsizes, yax, 'LineWidth', 2)
legend('Circular/Bootstrap', 'Data-Splitting', 'Location','northwest')
xlabel('N: Sample Size')
set(gca, 'XTick', 10:10:100)
ylabel('Average number of peaks per group of size N')
title('Average Number of Significant Voxels')
set(gcf, 'position', [0,550,1000,1000])
xlim([10,100])
export_fig(jgit(strcat('Plots/PaperPlots/Numberabovethresh/', type,'_',type2,'.pdf')), '-transparent')

