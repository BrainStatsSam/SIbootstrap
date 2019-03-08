function [top_av_boot, top_av_is, top_av_naive, top_MSE_boot, top_MSE_is, top_MSE_naive] = dispresSS(type, groupsize, nct, Jmax, B, plt)
% DISPRESSS(type, groupsize, B) displays a summary of the results obtained 
% for a set of different possible options.
%--------------------------------------------------------------------------
% ARGUMENTS
% type      Specifies whether we're looking at a t or a mean stat. Options
%           are 't','smootht' and 'mean'
% groupsize the size of the groups of subjects to test. The options are:
%           20, 25 and 50.
% B         the number of bootstrap iterations.
% m         m introduces potentially new masking. Need to analyse this
%           though.
%--------------------------------------------------------------------------
% OUTPUT
% A summary of the data.
%--------------------------------------------------------------------------
% EXAMPLES
% dispres('smootht',20,50)
%--------------------------------------------------------------------------
if nargin < 1
    type = 'smootht';
end
if nargin < 2
   	groupsize = 20;
end
if nargin < 5
    B = 50;
end     
if nargin < 6
    plt = 0;
end

if strcmp(type, 't') || strcmp(type, 'smootht') || strcmp(type, 'tstat') || strcmp(type, 'smoothtstat') 
    if nargin < 2
        groupsize = 20;
    end
    if nargin < 5
        B = 50;
    end
    if nargin < 3
        nct = 1;
    end
%     Jmax = 100;
elseif strcmp(type, 'm') || strcmp(type, 'mean')
    nct = 0;
    if nargin < 2
        groupsize = 20;
    end
    if nargin < 5
        B = 50;
    end
%     Jmax = 100;
elseif strcmp(type, 'sexglm') || strcmp(type,'glmsex')
    nct = 0;
    if nargin < 2
        groupsize = 20;
    end
    if nargin < 5
        B = 50;
    end
%     Jmax = 100;
elseif strcmp(type, 'SSmean') || strcmp(type, 'SSmean20')
    nct = 0;
    if nargin < 2
        groupsize = 20;
    end
    if nargin < 5
        B = 50;
    end
%     Jmax = 100;
else
    error('The inputted type is not defined');
end


% if strcmp(type, 'm')
%     filending = strcat('Results/tabularJmax',num2str(Jmax),'B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
%     fprintf('Results for the mean with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
% elseif strcmp(type, 't')
%     filending = strcat('Results/tstatJmax',num2str(Jmax),'B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
%     fprintf('Results for the t-stat with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
% end

if strcmp(type, 'm') || strcmp(type,'mean')
    filending = strcat('Results/mean','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
elseif strcmp(type, 't') || strcmp(type, 'tstat')
    filending = strcat('Results/tstat','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
elseif strcmp(type, 'smootht') || strcmp(type, 'smoothtstat')
    filending = strcat('Results/smoothtstat','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
elseif strcmp(type, 'sexglm') || strcmp(type,'glmsex')
    filending = strcat('Results/glmsex','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
elseif strcmp(type, 'SSmean')
    filending = '/vols/Scratch/ukbiobank/nichols/SelectiveInf/largefiles/SSmeanB50nsubj20Table.mat';
elseif strcmp(type, 'SSmean20')
    filending = strcat('Results/SSmean','B',num2str(B),'nsubj',num2str(groupsize),'LM20Data.csv');
end

disp(filending)
try
    if strcmp(type, 'SSmean')
        load(filending);
    else
        M = readtable(jgit(filending));
        M = table2array(M);
    end
catch
    error('You don''t have that set of variables stored or there are extra commas!')
end

if nargin < 4
    Jcurrent = M(:,1);
    Jmax = Jcurrent(end);
end


if strcmp(type, 'm') || strcmp(type,'mean')
    fprintf('Results for the mean with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize,Jmax, B);
elseif strcmp(type, 't')
    fprintf('Results for the t-stat with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
elseif strcmp(type, 'smootht')
    fprintf('Results for the smooth t-stat with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
elseif strcmp(type, 'sexglm') || strcmp(type,'glmsex')
    fprintf('Results for the Sex glm with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
end


boot = M(:,3);

if nct == 1
    naive = M(:,4)/nctcorrection(groupsize); %correcting for non-central t
    is = M(:,7)/nctcorrection(groupsize/2);
else
    naive = M(:,4); %correcting for non-central t
    is = M(:,7);
end


trueatloc = M(:,5);
trueatlocis = M(:,8);

biasboot = boot - trueatloc;
MSEboot = biasboot.^2;

biasnaive = naive - trueatloc;
MSEnaive = biasnaive.^2;

biasis = is - trueatlocis;
MSEis = biasis.^2;

%Biases:
warning('Averages are calculated over top 20 peaks not top 10!')
fprintf('Average Naive Bias: %0.4f\n',mean(biasnaive(1:20*Jmax)))
fprintf('Average Boot  Bias: %0.4f\n',mean(biasboot(1:20*Jmax)))
fprintf('Average Indep Bias: %0.4f\n\n',mean(biasis(1:20*Jmax)))

fprintf('Average Naive MSE: %0.4f\n',mean(MSEnaive(1:20*Jmax)))
fprintf('Average Boot  MSE: %0.4f\n',mean(MSEboot(1:20*Jmax)))
fprintf('Average Indep MSE: %0.4f\n\n',mean(MSEis(1:20*Jmax)))

top = 10;
top_av_naive = zeros(1,top);
top_av_boot = zeros(1,top);
top_av_is = zeros(1,top);

top_MSE_naive = zeros(1,top);
top_MSE_boot = zeros(1,top);
top_MSE_is = zeros(1,top);

for J = 1:top
    Jthpeak = J:20:(20*Jmax);
    top_av_naive(J) = mean(biasnaive(Jthpeak));
    top_av_boot(J) = mean(biasboot(Jthpeak));
    top_av_is(J) = mean(biasis(Jthpeak));
    
    top_MSE_naive(J) = mean(MSEnaive(Jthpeak));
    top_MSE_boot(J) = mean(MSEboot(Jthpeak));
    top_MSE_is(J) = mean(MSEis(Jthpeak));
end

top_av_naive
top_av_boot
top_av_is

top_MSE_naive
top_MSE_boot
top_MSE_is

if plt == 1
    cla
    p1 = plot(1:10,top_av_boot,'-o');
    set(p1,'LineWidth',1.5);
    hold on
    p2 = plot(1:10,top_av_is,'-o');
    set(p2,'LineWidth',1.5);
    p3 = plot(1:10,top_av_naive,'-o');
    set(p3,'LineWidth',1.5);
    legend('Boot','IndepSplit','Naive')
    % title('Comparison of the Biases')
    xlabel('Peak Number')
    ylabel('Average Bias')
    title(strcat('Method Bias for groups of size  ',' ',num2str(groupsize)))
    ax = gca;
    ax.FontSize = 15;
%     
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 4])
%     print('-djpeg', strcat('./Plots/OHBMbiasplot',num2str(groupsize),type,'.jpg'), '-r300')    
    pause
    cla
    p1 = plot(1:10,top_MSE_boot,'-o');
    set(p1,'LineWidth',1.5);
    hold on
    p2 = plot(1:10,top_MSE_is,'-o');
    set(p2,'LineWidth',1.5);
    p3 = plot(1:10,top_MSE_naive,'-o');
    set(p3,'LineWidth',1.5);
    legend('Boot','IndepSplit','Naive')
    % title('Comparison of the Biases')
    xlabel('Peak Number')
    ylabel('Average MSE')
    title(strcat('Method MSE for groups of size',' ',num2str(groupsize)))
    ax = gca;
    ax.FontSize = 15;
% 
%     set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 4])
%     print('-djpeg', strcat('./Plots/OHBMMSEplot',num2str(groupsize),type,'.jpg'), '-r300')
elseif plt == 2
    %BOXPLOT TIME!
    cla
    boxplot([top_av_boot; top_av_is; top_av_naive]')
    title(strcat('Method Bias for groups of size 50 over top 20 peaks.'))
    export_fig boxplot-ex.pdf
end

end

