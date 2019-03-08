type = 'tstat';
groupsize = 20;
B = 50;

if strcmp(type, 'm') || strcmp(type,'mean')
    filending = strcat('Results/mean','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
elseif strcmp(type, 't') || strcmp(type, 'tstat')
    filending = strcat('Results/tstat','B',num2str(B),'nsubj',num2str(groupsize),'ThreshData.csv');
elseif strcmp(type, 'smootht') || strcmp(type, 'smoothtstat')
    filending = strcat('Results/smoothtstat','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
elseif strcmp(type, 'sexglm') || strcmp(type,'glmsex')
    filending = strcat('Results/glmsex','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
elseif strcmp(type, 'SSmean')
    filending = '/vols/Scratch/ukbiobank/nichols/SelectiveInf/largefiles/SSmeanB50nsubj20Table.mat';
elseif strcmp(type, 'SSmeanLM')
    filending = strcat('Results/SSmean','B',num2str(B),'nsubj',num2str(groupsize),'LM20Data.csv');
end

try
    if strcmp(type, 'SSmean')
        load(filending);
    else
        M = readtable(jgit(filending));
    end
catch
    error('You don''t have that set of variables stored or there are extra commas!')
end
A = table2array(M);


if strcmp(type, 'mean')
    type = 0;
elseif strcmp(type, 'tstat') || strcmp(type, 't')
    type = 1;
    smooth_var = 0;
elseif strcmp(type, 'smoothtstat') || strcmp(type, 'smootht')
    type = 1;
    smooth_var = 1;
elseif strcmp(type, 'sexglm')
    type = 2;
end

%Generate filestart
smooth_var = 0;
if type == 0
    filestart = strcat('mean','B', num2str(B), 'nsubj',num2str(groupsize));
elseif type == 1
    filestart = strcat('tstat', 'B', num2str(B), 'nsubj',num2str(groupsize));
    if smooth_var == 1
        filestart = strcat('smooth', filestart);
    end
elseif type == 2
    filestart = strcat('glmsex', 'B', num2str(B), 'nsubj',num2str(groupsize));
end
filestart = strcat(filestart, 'Thresh');

%%
save(strcat(jgit('/Results/'), filestart,'Data'), 'A');