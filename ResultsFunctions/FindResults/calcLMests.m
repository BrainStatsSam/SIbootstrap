function calcLMests(B, groupsize, Jmax, variables, smooth_var)
% CALCLMESTS(B, groupsize, Jmax, type) returns the estimates obtained under
% bootstrapping for estimating R^2 in the linear model.
%--------------------------------------------------------------------------
% ARGUMENTS
% B         the number of bootstrap iterations.
% groupsize the size of the groups of subjects to test.
% Jmax      the total number of groups to test. Note that there are of
%           course contraints on this because of the amount of data.
%           Error checking for this is included.
% type      Specifies whether we're looking at a t or a mean stat
% variables specifieds the variables to regress.
%--------------------------------------------------------------------------
% OUTPUT
% A csv file with the the results.
%--------------------------------------------------------------------------
% EXAMPLES
% calcests(50,20,10)
% calcests(50,20,100)
%
% %To run the t-stat.
% calcests(50,20,100,1)
%--------------------------------------------------------------------------
% SEE ALSO
%
if nargin < 4
    variables = {'sex'};
if nargin < 5
    smooth_var = 0; %Meaning that the normal mean is targetted not the t-img.
end
if length(variables) > 1
   error('Two many variables for now!'); 
end
if ~(strcmp(variables{1},'sex') || strcmp(variables{1},'Age'))
    error('the variables must be age or sex for now')
end

%Ensure that Jmax isn't too high!
if Jmax > floor(4945/groupsize)
    error('Jmax is too high!')
end

xvar = bbvars(variables{1}, 0);

global TYPE

nSubj = groupsize;
nVox = 91*109*91;

%Set up file processing stuff.
header = 'simulation,peak,boot,naive,trueatloc,locmaxindices,is,trueatlocis,locmaxindicesis';
filestart = strcat('Lm', variables{1}, 'R2','B', num2str(B), 'nsubj',num2str(nSubj));

%Test is some progress has already been made in which case continue the
%progress!
try
    if strcmp(TYPE, 'jala')
        currentdata = readcsv(strcat(jgit('/Results/'), filestart,'Data.csv'));
    end
    Jcurrent = currentdata(:,1);
    Jcurrent = Jcurrent(end);
catch
    Jcurrent = 0;
end

true_R2 = imgload(strcat(variables{1},'lm_R2'));
true_R2 = true_R2(:)';

npeaks = 20;
nentries = npeaks*Jmax;

simulation = repmat(1:Jmax, npeaks,1);
simulation = simulation(:)';
peaks = repmat(1:npeaks, 1, Jmax);

estboot = zeros(1, nentries);
estnaive = zeros(1, nentries);
trueatloc = zeros(1, nentries);
locmaxindices = zeros(1, nentries);

estis = zeros(1, nentries);  %is stands for independent splitting
trueatlocis = zeros(1, nentries);
locationis = zeros(1, nentries);

for J = Jcurrent:(Jmax-1)
    disp(J + 1)
    placeat = (J*20 + 1):(J*20 + 20);  %20 is the number of peaks here
    which_subs = (J*groupsize + 1):(J*groupsize + groupsize);
    
    data = zeros([nSubj, nVox]);
    for I = 1:nSubj
        img = readimg(I+J*groupsize);
        data(I,:) = img(:);
    end
   
    [ est , estwas, trueval, top_lm_indices ] = glmbias( local, top, B, xvar(which_subs), data, true_R2);
    
    estboot(placeat) = est;
    estnaive(placeat) = estwas;
    trueatloc(placeat) = trueval;
    locmaxindices(placeat) = top_lm_indices;
    
    %Below 20 is the number of peaks
    [ est, trueval, top_lm_indices ] = glmindepsplit( xvar, data, top, true_R2, smooth_var);
    
    estis(placeat) = est;
    trueatlocis(placeat) = trueval;
    locationis(placeat) = top_lm_indices;
end

% header = {'simulation','peak','boot','naive','trueatloc','locmaxindices','is','trueatlocis','locmaxindicesis'};

%Append if no data has previously been recorded
if Jcurrent > 0
    append = 1;
else
    append = 0;
end

A = [simulation', peaks', estboot', estnaive', trueatloc', locmaxindices', estis', trueatlocis', locationis'];
A = A((Jcurrent*npeaks+1):Jmax*npeaks,:);

%Save data
writecsv(A, 3, header, jgit('/Results/'), strcat(filestart,'Data.csv'), append)
end

