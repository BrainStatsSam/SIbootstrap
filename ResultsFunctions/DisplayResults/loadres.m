function M = loadres(type, groupsize, B)
% DISPRES(type, groupsize, B) displays a summary of the results obtained 
% for a set of different possible options.
%--------------------------------------------------------------------------
% ARGUMENTS
% type      Specifies whether we're looking at a t or a mean stat. Options
%           are 't','smootht' and 'mean'
% groupsize the size of the groups of subjects to test. The options are:
%           20, 25 and 50.
% variable  specificies whether you want to extract a specific variable.
%           Default is 'all'.
% B         the number of bootstrap iterations.
%--------------------------------------------------------------------------
% OUTPUT
% A summary of the data.
%--------------------------------------------------------------------------
% EXAMPLES
% M = loadres('smootht',20)
%--------------------------------------------------------------------------
if nargin < 1
    type = 'smootht';
end
if nargin < 2
   	groupsize = 20;
end
if nargin < 4
    B = 100;
end    
warning('masktype not set for vbmage')

if strcmp(type, 'm') || strcmp(type,'mean')
    filending = strcat('Results/mean','B',num2str(B),'nsubj',num2str(groupsize),'Thresh.mat');
elseif strcmp(type, 't') || strcmp(type, 'tstat')
    filending = strcat('Results/tstat','B',num2str(B),'nsubj',num2str(groupsize),'Thresh.mat');
elseif strcmp(type, 'smootht') || strcmp(type, 'smoothtstat')
    filending = strcat('Results/smoothtstat','B',num2str(B),'nsubj',num2str(groupsize),'Thresh.mat');
elseif strcmp(type, 'sexglm') || strcmp(type,'glmsex')
    filending = strcat('Results/glmsex','B',num2str(B),'nsubj',num2str(groupsize),'Thresh.mat');
elseif strcmp(type, 'SSmean')
    filending = '/vols/Scratch/ukbiobank/nichols/SelectiveInf/largefiles/SSmeanB50nsubj20Table.mat';
elseif strcmp(type, 'SSmeanLM')
    filending = strcat('Results/SSmean','B',num2str(B),'nsubj',num2str(groupsize),'LM20Thresh.mat');
elseif strcmp(type, 'vbmsex') || strcmp(type, 'sexvbm')
    filending = strcat('Results/vbmsex','B',num2str(B),'nsubj',num2str(groupsize),'Thresh.mat');
elseif strcmp(type, 'vbmage') || strcmp(type, 'agevbm')
    filending = strcat('Results/vbmage','B',num2str(B),'nsubj',num2str(groupsize),'Thresh.mat');
elseif strcmp(type, 'vbmage001') || strcmp(type, 'agevbm')
    filending = strcat('Results/vbmage','B',num2str(B),'nsubj',num2str(groupsize),'Threshvbmmask001.mat');
else
    error('The inputted type is not defined');
end
filending
try
    temp = load(jgit(filending));
catch
    error('You don''t have that set of variables stored or there are extra commas!')
end
M = temp.A;

end

