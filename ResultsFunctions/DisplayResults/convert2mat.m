type_set = {'mean', 'tstat', 'smoothtstat', 'sexglm'};
B = 50;
nsubj_set = {20,50,100};

for I = type_set
    for J = nsubj_set
        type = I{1};
        groupsize = J{1};
        
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
        elseif strcmp(type, 'SSmeanLM')
            filending = strcat('Results/SSmean','B',num2str(B),'nsubj',num2str(groupsize),'LM20Data.csv');
        end
        
        M = table2array(M);
    end
end

