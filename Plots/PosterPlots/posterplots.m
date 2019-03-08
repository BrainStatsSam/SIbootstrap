%Bias Plot
M = readtable(jgit('Results/Jmax50B50nsubj20avdiff.csv'));
M = table2array(M);

p1 = plot(1:20,M(:,1),'-o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(1:20,M(:,2),'-o');
set(p2,'LineWidth',1.5);
p3 = plot(1:20,M(:,3),'-o');
set(p3,'LineWidth',1.5);
legend('boot','indepsplit','naive')
% title('Comparison of the Biases')
xlabel('Peak Number')
ylabel('Average Bias')

%Plots for the first poster you made.

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 4])
% print -djpeg ./Plots/posterbiasplot.jpg -r300
print('-djpeg', jgit('Plots/Poster Plots/posterbiasplot.jpg'), '-r300')

%MSE plot
cla
M = readtable('./Results/Jmax50B50nsubj20sqdiff.csv');
M = table2array(M);

p1 = plot(1:20,M(:,1),'-o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(1:20,M(:,2),'-o');
set(p2,'LineWidth',1.5);
p3 = plot(1:20,M(:,3),'-o');
set(p3,'LineWidth',1.5);
legend('boot','indepsplit','naive')
% title('Comparison of the MSEs')
xlabel('Peak Number')
ylabel('MSE')

set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 4])
% print -djpeg ./Plots/posterMSEplot.jpg -r300
print('-djpeg', jgit('Plots/Poster Plots/posterMSEplot.jpg'), '-r300')