function out = dispres_thresh(type, groupsize, masktype, printres, nct, Jmax , nboot)
% DISPRES_THRESH records the thresholded results.
%--------------------------------------------------------------------------
% ARGUMENTS
% type          'mean' or 'tstat'
% groupsize     the number of subjects in each small group
% nct           0/1 noncentral t correction. 1 corrects for the mean of a
%               noncentral t distribution. Deafult it 1. (Only applicable
%               to the 'tstat' case.
% Jmax          the maximum number of realizations to include.
% B             the number of boostrap resamples. Always 50.
%--------------------------------------------------------------------------
% OUTPUT
% out           a structural array with vectors containing the bias and mse
%               for each of the methods: is, naive, boot. Eg out.biasis and
%               out.MSEis are the bias and MSE for Data-Splitting.
%Stuff to talk to Tom about:
% 1) The current approach to thresholding is inducing bias in the IS
% estimates. This is because the peaks that are chosen are the ones that
% are necessarily about a threshold (ie all 50 subjects give that) so in
% their locations each group of 25 subjects will naturally be inflated. The
% fair comparison is probably to instead determine which peaks are
% signficant separately. The trouble with this is that you get different
% numbers of significant peaks depending which method that you use. Is this
% a problem? For the mean this would mean choosing a different threshold
% for IS and bootstrapping which would be arbitrary and hard to justify. So
% shall we stick to the top 20 peaks in that case? Sticking to the top 20 doesn't cause any problems.
% 2) For the t-thresholding, shall I go back through and threshold
% everything separately?
% 3) For connected components, figure out stuff! Need to get one max per
% cluster.
%--------------------------------------------------------------------------
% EXAMPLES
% dispres_thresh('mean', 20)
% dispres_thresh('tstat', 20)
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.

if nargin < 1
    type = 'smootht';
end
if nargin < 2
    groupsize = 20;
end
if nargin < 3
    masktype = '001';
end
if nargin < 4
    printres = 1;
end
if nargin < 7
    nboot = 100;
end
if strcmp(masktype, '01')
    masktype = 'vbm_mask01';
elseif strcmp(masktype, '001')
    masktype = 'vbm_mask001';
end

if strcmp(type, 't') || strcmp(type, 'smootht') || strcmp(type, 'tstat') || strcmp(type, 'smoothtstat')
    if nargin < 5
        nct = 1;
    end
elseif strcmp(type, 'vbmagesext') || strcmp(type, 'vbmagesexfish') || strcmp(type, 'vbmagesexR2') || strcmp(type, 'vbmagesexf2') || strcmp(type, 'vbmageR2') || strcmp(type, 'vbmagef2') || strcmp(type, 'SSmean') || strcmp(type, 'SSmeanLM') || strcmp(type, 'sexglm') || strcmp(type,'glmsex') || strcmp(type, 'm') || strcmp(type, 'mean') || strcmp(type, 't4lm')
    nct = 0;
else
    error('The inputted type is not defined');
end

if strcmp(type, 'm') || strcmp(type,'mean')
    filending = strcat('Results/mean','B',num2str(nboot),'nsubj',num2str(groupsize),'Thresh.mat');
elseif strcmp(type, 't') || strcmp(type, 'tstat')
    filending = strcat('Results/tstat','B',num2str(nboot),'nsubj',num2str(groupsize),'Thresh.mat');
elseif strcmp(type, 't4lm')
    filending = strcat('Results/t4lm','B',num2str(nboot),'nsubj',num2str(groupsize),'Thresh.mat');
elseif length(type) > 6 && length(type) < 9 && strcmp(type(1:6), 'vbmage')
    filending = strcat('Results/vbmage','B',num2str(nboot),'nsubj',num2str(groupsize),'Thresh',masktype,'.mat');
elseif length(type) > 8 && strcmp(type(1:9), 'vbmagesex')
    filending = strcat('Results/vbmagesex','B',num2str(nboot),'nsubj',num2str(groupsize),'Thresh',masktype,'.mat');
end
filending
try
    temp = load(jgit(filending));
catch
    error('You don''t have that set of variables stored or there are extra commas!')
end

A = temp.A;
B = temp.B;
try
    C = temp.C;
    D = temp.D;
end

if nargin < 4
    Jcurrent = A(:,1);
    Jmax = Jcurrent(end);
end

if printres
    if strcmp(type, 'm') || strcmp(type,'mean')
        fprintf('Results for the mean with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize,Jmax, nboot);
    elseif strcmp(type, 't')
        fprintf('Results for the t-stat with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, nboot);
    elseif strcmp(type, 'smootht')
        fprintf('Results for the smooth t-stat with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, nboot);
    elseif strcmp(type, 'sexglm') || strcmp(type,'glmsex')
        fprintf('Results for the Sex glm with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, nboot);
    elseif strcmp(type, 'SSmean')
        fprintf('Results for the SSmean with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, nboot);
    elseif strcmp(type, 'SSmeanLM')
        fprintf('Results for the top SSmean LM with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, nboot);
    end
end

if strcmp(type, 'vbmageR2') || strcmp(type, 'vbmagesexR2')
    boot = A(:,3);
    naive = A(:,5);
    is = B(:,3);
    trueatloc = A(:,9);
    trueatlocis = B(:,5);
elseif strcmp(type, 'vbmagef2') || strcmp(type, 'vbmagesexf2')
    boot = A(:,4);
    naive = A(:,6);
    is = B(:,4);
    trueatloc = A(:,8);
    trueatlocis = B(:,6);
elseif strcmp(type, 'vbmaget') || strcmp(type, 'vbmagesext')
    boot = -sign(C(:,3)).*sqrt(F2R(C(:,3).^2, groupsize, 3, 2));
    naive = -sign(C(:,6)).*sqrt(F2R(C(:,6).^2, groupsize, 3, 2));
    is = -D(:,3);
    trueatloc = -C(:,5);
    trueatlocis = -D(:,4);
elseif strcmp(type, 'vbmagefish') || strcmp(type, 'vbmagesexfish')
    boot = -fishtrans(C(:,4), 1);
    naive = -fishtrans(C(:,7), 1);
    is = -D(:,3);
    trueatloc = -C(:,5);
    trueatlocis = -D(:,4);
elseif strcmp(type, 'mean') || strcmp(type, 't4lm')
    boot = A(:,3)/100;
    naive = A(:,4)/100;
    is = B(:,3)/100;
    trueatloc = A(:,5)/100;
    trueatlocis = B(:,4)/100;
else
    if nct == 1
        boot = A(:,3)/nctcorrection(groupsize);
        naive = A(:,4)/nctcorrection(groupsize); %correcting for non-central t
        is = B(:,3)/nctcorrection(groupsize/2);
    else
        boot = A(:,3);
        naive = A(:,4);
        is = B(:,3);
    end
    trueatloc = A(:,5);
    trueatlocis = B(:,4);
end


out.biasboot = boot(~isnan(boot)) - trueatloc(~isnan(boot));
out.MSEboot = out.biasboot.^2;

out.biasnaive = naive(~isnan(boot)) - trueatloc(~isnan(boot));
out.MSEnaive = out.biasnaive.^2;

out.biasis = is(~isnan(is)) - trueatlocis(~isnan(is));
out.MSEis = out.biasis.^2;

if printres
    fprintf('The Average Bias and MSE averaged over all the significant peaks:\n')
    
    fprintf('Average Naive bias: %0.4f\n',mean(out.biasnaive))
    fprintf('Average Boot  bias: %0.4f\n',mean(out.biasboot))
    fprintf('Average Indep bias: %0.4f\n',mean(out.biasis))
    fprintf('Average Naive MSE: %0.4f\n',mean(out.MSEnaive))
    fprintf('Average Boot  MSE: %0.4f\n',mean(out.MSEboot))
    fprintf('Average Indep MSE: %0.4f\n',mean(out.MSEis))
end

end

