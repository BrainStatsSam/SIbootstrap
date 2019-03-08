[ boot, naive, trueatloc, is, trueatlocis ] = extractdata('smootht', 20, 2, 50);

plot(naive,boot,'*','MarkerSize', 8 );
% hold on
% x = 0.5:0.01:2;
% plot(x,x)
title('Bootstrap vs Naive')
xlim([0.8, 1.8])
ylim([0.8 1.8])
xlabel('Naive')
ylabel('Bootstrap')
refline(1,0)
pbaspect([1 1 1])
set(gcf, 'position', [500,500,600,500])
set(gca,'fontsize', 18)
% set(gca,'XTick',0.8:0.1:1.8);
% export_fig plot1.pdf -transparent

export_fig(jgit('Plots/OHBMplots/plot1.pdf'), '-transparent')



%%
plot(1:5,[1:5]-2*rand(1,5),'o');xlim([0 5]);ylim([0 5]);refline(1,0);pbaspect([1 1 1]);    




% cla
% plot(trueatloc,boot,'*')
% hold on
% plot(x,x)
% title('Boot vs Truth')
% export_fig plot2.pdf
% 
% cla
% plot(trueatloc,naive, '*')
% hold on
% plot(x,x)
% title('Naive vs Truth')
% export_fig plot3.pdf