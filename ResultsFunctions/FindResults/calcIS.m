function calcIS(B, groupsize, Jmax, type, smooth_var)
% CALCESTS(B, groupsize, Jmax, type) returns the estimates obtained under
% independent splitting for a variety of subject divisions.
%--------------------------------------------------------------------------
% ARGUMENTS
% B         the number of bootstrap iterations.
% groupsize the size of the groups of subjects to test.
% Jmax      the total number of groups to test. Note that there are of
%           course contraints on this because of the amount of data.
%           Error checking for this is included.
% type      Specifies whether we're looking at a t or a mean stat.
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
    type = 0; 
end
if nargin < 5
    smooth_var = 0;
end


%Ensure that Jmax isn't too high!
if Jmax > floor(4945/groupsize)
    error('Jmax is too high!')
end

global TYPE

nSubj = groupsize;
nVox = 91*109*91;

%Set up file processing stuff.
header = 'simulation,peak,boot,naive,trueatloc,locmaxindices,is,trueatlocis,locmaxindicesis';
if type == 0
    filestart = strcat('mean','B', num2str(B), 'nsubj',num2str(nSubj));
else
    filestart = strcat('tstat', 'B', num2str(B), 'nsubj',num2str(nSubj));
    if smooth_var == 1
        filestart = strcat('smooth', filestart);
    end
end
filestart = strcat('IS', filestart);

%Test is some progress has already been made in which case continue the
%progress!
try
    if strcmp(TYPE, 'jala')
        currentdata = readcsv(strcat(jgit('/Results/'), filestart,'Data.csv'));
    else
        currentdata = readcsv(strcat(jgit('/Results/testres/'), filestart,'Data.csv'));
    end
    Jcurrent = currentdata(:,1);
    Jcurrent = Jcurrent(end);
catch
    Jcurrent = 0;
end

% Jmaxpossible = floor(4945/groupsize);
% if type == 0
%     filestart = strcat('tabular','Jmax', num2str(Jmax), 'B', num2str(B), 'nsubj',num2str(nSubj));
% else
%     filestart = strcat('tstat','Jmax', num2str(Jmax), 'B', num2str(B), 'nsubj',num2str(nSubj));
% end

if type == 0
    ImgMean = imgload('mean');
else
    ImgMean = imgload('mos');
end

npeaks = 20;
nentries = npeaks*Jmax;

simulation = repmat(1:Jmax, npeaks,1);
simulation = simulation(:)';
peaks = repmat(1:npeaks, 1, Jmax);

estis = zeros(1, nentries);  %is stands for independent splitting
trueatlocis = zeros(1, nentries);
locationis = zeros(1, nentries);

% mask = imgload('mask');

for J = Jcurrent:(Jmax-1)
    disp(J + 1)
    placeat = (J*20 + 1):(J*20 + 20);  %20 is the number of peaks here
    which_subs = (J*groupsize + 1):(J*groupsize + groupsize);
    
    data = zeros([nSubj, nVox]);
    for I = 1:nSubj
        img = readimg(I+J*groupsize, 2); %So that it generates from the alternative subject list.
%         img = img.*mask;
        data(I,:) = img(:);
    end
    
    %Below 20 is the number of peaks
    if type == 0
        [ est, trueval, top_lm_indices ] = indepsplit( which_subs, 20, ImgMean);
    else
        [ est, trueval, top_lm_indices ] = tindepsplit( data, 20, ImgMean, smooth_var);
%         [ est, trueval, top_lm_indices ] = tindepsplitold( which_subs, 20, ImgMean, smooth_var);

        %Change this so that you ensure that it takes in the same subjects
        %as the first lot!
    end
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

A = [simulation', peaks', estis', trueatlocis', locationis'];
A = A((Jcurrent*npeaks+1):Jmax*npeaks,:);
%Save data
if strcmp(TYPE,'jala')
    writecsv(A, 3, header, jgit('/Results/'), strcat(filestart,'Data.csv'), append)
else
    writecsv(A, 3, header, jgit('/Results/testres/'), strcat(filestart,'Data.csv'), append)
end

end

