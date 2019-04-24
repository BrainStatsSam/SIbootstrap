function out = dispres_sims_thresh( type, groupsize, std_dev, FWHM, version, printres )
% dispres_sims_thresh( type, groupsize, std_dev, FWHM, version, printres )
% displays a summary of the results obtained for a set of different possible options.
%--------------------------------------------------------------------------
% ARGUMENTS
% type      Specifies whether we're looking at a t or a mean stat. Options
%           are 't' (Cohen's d at Cohen's d peaks), 't4lm' (mean at Cohen's d peaks)
%           'R2' (R2 at R2 peaks) and 'mean' (mean at mean peaks).
% groupsize the size of the groups of subjects to test.
% nct       0/1 whether or not to divide by the correction factor for 
%           the non-central t-distribution (C_N from the paper). Default is 1.
% top       the number of peaks to average over
% B         the number of bootstrap iterations.
%--------------------------------------------------------------------------
% OUTPUT
% out       the output which is a structure such that:
% out.mseboot, out.msenaive, out.mseis are the MSEs from applying the
% bootstrap, naive (circular) and independent splitting/data splitting methods.
% out.biasboot, out.biasnaive, out.biasis are the biases from applying the
% bootstrap, naive (circular) and independent splitting/data splitting methods.
%--------------------------------------------------------------------------
% EXAMPLES
%--------------------------------------------------------------------------
if nargin < 2
    groupsize = 20;
end
if nargin < 3
    std_dev = 1;
end
if nargin < 4
    FWHM = 6;
end
if nargin < 5
    version = 2;
end
if nargin < 6
    printres = 1;
end
global davenpor
global lobal

if floor(FWHM) ~= FWHM
    FWHM = strcat(num2str(floor(FWHM)), 'point', num2str(5));
else
    FWHM = num2str(FWHM);
end
FWHM

if strcmp(type, 'tstat')
    filestart = strcat('tstatThresh/B100sd',num2str(std_dev),'FWHM', FWHM, 'nsubj',num2str(groupsize),'SIMS');
    nct = 1;
elseif strcmp(type, 't4lm')
    filestart = strcat('t4lmThresh/B100sd',num2str(std_dev),'FWHM', FWHM, 'nsubj',num2str(groupsize),'SIMS');
    nct = 0;
elseif strcmp(type, 'mean')
    filestart = strcat('meanThresh/B100sd',num2str(std_dev),'FWHM', FWHM, 'nsubj',num2str(groupsize),'SIMS');
    nct = 0;
elseif strcmp(type, 'mean2')
    filestart = strcat('mean2Thresh/B100sd',num2str(std_dev),'FWHM', FWHM, 'nsubj',num2str(groupsize),'SIMSversion2');
    nct = 0;
elseif strcmp(type, 'R2')
    filestart = strcat('R2Thresh/B100sd',num2str(std_dev),'FWHM', FWHM, 'nsubj',num2str(groupsize),'SIMS');
    nct = 0;
else
    type
    error('This type is not stored')
end

try
    if version == 1
        strcat(lobal,'TomsMiniProject/Matlab/Sims/Results/', filestart)
        tempo = load(strcat(lobal,'TomsMiniProject/Matlab/Sims/Results/', filestart));
    elseif version == 3
        tempo = load(strcat(davenpor,'/SubmittedCode/SIbootstrap/Sims/', filestart));
        nct = 0;
    elseif version == 2
        strcat(davenpor,'jalagit/Sims/', filestart)
        tempo = load(strcat(davenpor,'jalagit/Sims/', filestart));
    end
catch
    error('You don''t have that set of variables stored')
end
A = tempo.A;
B = tempo.B;

Jcurrent = A(:,1);
Jmax = Jcurrent(end);

if printres == 1
    if strcmp(type, 'm') || strcmp(type,'mean')
        fprintf('Results for the mean with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize,Jmax, B);
    elseif strcmp(type, 't')
        fprintf('Results for the t-stat with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
    elseif strcmp(type, 'smootht')
        fprintf('Results for the smooth t-stat with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
    elseif strcmp(type, 'sexglm') || strcmp(type,'glmsex')
        fprintf('Results for the Sex glm with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
    elseif strcmp(type, 'SSmean')
        fprintf('Results for the SSmean with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
    elseif strcmp(type, 'SSmeanLM')
        fprintf('Results for the top SSmean LM with nSubj = %d, Jmax = %d and B = %d.\n\n',groupsize, Jmax, B);
    end
end

boot = A(:,3);

if nct == 1
    naive = A(:,4)/nctcorrection(groupsize); %correcting for non-central t
    if isempty(B)
        is = NaN;
    else
        is = B(:,3)/nctcorrection(groupsize/2);
    end
else
    naive = A(:,4); %correcting for non-central t
    is = B(:,3);
end

trueatloc = A(:,5);
if isempty(B)
    trueatlocis = NaN;
else
    trueatlocis = B(:,4);
end

warning('Need to modify!!! away from sqrt(), just needed for testing')
if version == 2 && strcmp(type, 'R2') %This mistake only happened for the R2 stuff!
    out.biasis = is - sqrt(trueatlocis);
    out.biasnaive = naive - sqrt(trueatloc);
    out.biasboot = boot - sqrt(trueatloc);
elseif version == 3 && strcmp(type, 'R2') %This mistake only happened for the R2 stuff!
    out.biasis = is - sqrt(trueatlocis);
    out.biasnaive = naive - trueatloc;
    out.biasboot = boot - trueatloc;
else
    out.biasis = is - trueatlocis;
    out.biasnaive = naive - trueatloc;
    out.biasboot = boot - trueatloc;
end

out.mseboot = out.biasboot.^2;
out.msenaive = out.biasnaive.^2;
out.mseis = out.biasis.^2;

out.biasboot = out.biasboot(~isnan(out.biasboot));
out.biasnaive = out.biasnaive(~isnan(out.biasnaive));
out.biasis = out.biasis(~isnan(out.biasis));

out.mseboot = out.mseboot(~isnan(out.mseboot));
out.msenaive = out.msenaive(~isnan(out.msenaive));
out.mseis = out.mseis(~isnan(out.mseis));

if printres
    fprintf('The Average Bias and MSE averaged over all the significant peaks:\n')
    
    fprintf('Average Naive bias: %0.4f\n',mean(out.biasnaive))
    fprintf('Average Boot  bias: %0.4f\n',mean(out.biasboot))
    fprintf('Average Indep bias: %0.4f\n',mean(out.biasis))
    fprintf('Average Naive MSE: %0.4f\n',mean(out.msenaive))
    fprintf('Average Boot  MSE: %0.4f\n',mean(out.mseboot))
    fprintf('Average Indep MSE: %0.4f\n',mean(out.mseis))
end

end

