function [M, biasboot, biasnaive, biasis, MSEboot, MSEnaive, MSEis] = loadres(type, groupsize, variable, B)
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
% M = loadres('smootht',20,50)
%--------------------------------------------------------------------------
if nargin < 1
    type = 'smootht';
end
if nargin < 2
   	groupsize = 20;
end
if nargin < 3
    variable = 'all';
end
if nargin < 4
    B = 50;
end   


if strcmp(type, 't') || strcmp(type, 'smootht') || strcmp(type, 'smoothtstat') || strcmp(type, 'tstat')
    if nargin < 2
        groupsize = 20;
    end
    if nargin < 3
        B = 50;
    end
elseif strcmp(type, 'm') || strcmp(type, 'mean')
    if nargin < 2
        groupsize = 20;
    end
    if nargin < 3
        B = 50;
    end
else
    error('The inputted type is not defined');
end

if strcmp(type, 'm') || strcmp(type,'mean')
    filending = strcat('Results/mean','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
elseif strcmp(type, 't') || strcmp(type, 'tstat')
    filending = strcat('Results/tstat','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
elseif strcmp(type, 'smootht') || strcmp(type, 'smoothtstat')
    filending = strcat('Results/smoothtstat','B',num2str(B),'nsubj',num2str(groupsize),'Data.csv');
end


try
    M = readtable(jgit(filending));
catch
    error('You don''t have that set of variables stored or there are extra commas!')
end

arrayM = table2array(M);
Jcurrent = arrayM(:,1);
Jmax = Jcurrent(end);

if strcmp(type, 'm') || strcmp(type,'mean')
    fprintf('Results for the mean with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize,Jmax, B);
elseif strcmp(type, 't')
    fprintf('Results for the t-stat with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
elseif strcmp(type, 'smootht')
    fprintf('Results for the smooth t-stat with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
end


boot = arrayM(:,3);
naive = arrayM(:,4);
trueatloc = arrayM(:,5);
is = arrayM(:,7);
trueatlocis = arrayM(:,8);

biasboot = boot - trueatloc;
MSEboot = biasboot.^2;

biasnaive = naive - trueatloc;
MSEnaive = biasnaive.^2;

biasis = is - trueatlocis;
MSEis = biasis.^2;

if strcmp(variable, 'all')
    M = arrayM;
else
    M = M{:, variable};
end

end

