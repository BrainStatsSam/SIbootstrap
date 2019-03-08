type = 'tstat';
nsubj = '50';

M = readtable(jgit(strcat('Results/',type,'B50nsubj',nsubj,'Data.csv')));

% M.Properties.VariableNames
M = table2array(M);


naive = M(:,4);
truenaiveboot = M(:,5);
is = M(:,7);
boot = M(:,3);
trueatlocis = M(:,8);
%% ests versus truth

cla
p1 = plot(trueatlocis, is,'o');
set(p1,'LineWidth',1.5);
hold on
p2 = plot(truenaiveboot, naive,'o');
set(p2,'LineWidth',1.5);
p3 = plot(truenaiveboot, boot,'o');
set(p3,'LineWidth',1.5);
xlabel('True Xbar')
ylabel('Xbar estimate')
pbaspect([1 1 1])
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
pause

%% Naive Estimates
cla
p2 = plot(naive,is,'o');
set(p2,'LineWidth',1.5);
hold on
p1 = plot(naive,boot,'o');
set(p1,'LineWidth',1.5);
xlabel('Naive Xbar')
ylabel('Unbiased Xbar')
rline = refline(1,0);
rline.Color = 'b';
pbaspect([1 1 1])
title('Plotting the Estimates against the Naive values')
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
legend('Data Splitting', 'Bootstrap', 'Location','NorthWest')
set(gcf, 'position', [500,500,600,600])