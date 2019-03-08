function calcests(B, groupsize, Jmax, type )
% CALCESTS(B, groupsize, Jmax, type) returns the estimates obtained under
% bootstrapping.
%--------------------------------------------------------------------------
% ARGUMENTS
% B         the number of bootstrap iterations.
% groupsize the size of the groups of subjects to test.
% Jmax      the total number of groups to test. Note that there are of
%           course contraints on this because of the amount of data.
%           Error checking for this is included.
% type      Either mean, tstat or smoothtstat or glmsex
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
    type = 0; %Meaning that the normal mean is targetted not the t-img.
end


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
elseif type == 1
    filestart = strcat('tstat', 'B', num2str(B), 'nsubj',num2str(nSubj));
    if smooth_var == 1
        filestart = strcat('smooth', filestart);
    end
elseif type == 2
    filestart = strcat('glmsex', 'B', num2str(B), 'nsubj',num2str(nSubj));
end

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

if Jcurrent >= Jmax 
    return
end

% Jmaxpossible = floor(4945/groupsize);
% if type == 0
%     filestart = strcat('tabular','Jmax', num2str(Jmax), 'B', num2str(B), 'nsubj',num2str(nSubj));
% else
%     filestart = strcat('tstat','Jmax', num2str(Jmax), 'B', num2str(B), 'nsubj',num2str(nSubj));
% end

if type == 0
    ImgMeanorMos = imgload('fullmean');
elseif type == 1
    ImgMeanorMos = imgload('fullmos');
elseif type == 2
    ImgMeanorMos = imgload('full_sexlm_R2sex');
    Sexvar = bbvars( 'Sex', 0 );
end
Sig = ImgMeanorMos(:)';

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

MNImask = imgload('MNImask');
global stdsize

for J = Jcurrent:(Jmax-1)
    subject_mask = ones(stdsize);
    
    disp(J + 1)
    placeat = (J*20 + 1):(J*20 + 20);  %20 is the number of peaks here
    %     which_subs = (J*groupsize + 1):(J*groupsize + groupsize);
    
    data = zeros([nSubj, nVox]);
    for I = 1:nSubj
        img = readimg(I+J*groupsize);
        subject_mask = subject_mask.*readimg(I+J*groupsize, 'mask');
        data(I,:) = img(:);
    end
    
    subject_mask = subject_mask.*MNImask;
    
    if type == 0
        [ est , estwas, trueval, top_lm_indices ] = lmbias(1, 20, B, data, Sig, subject_mask);
    elseif type == 1
        [ est , estwas, trueval, top_lm_indices ] = tbias(1, 20, B, data, Sig, smooth_var, subject_mask);
    elseif type == 2
        xvar = Sexvar(1+J*groupsize:(J+1)*(groupsize));
        [ est , estwas, trueval, top_lm_indices ] = glmbias(1, 20, B, xvar', data, Sig, subject_mask);
    end
    estboot(placeat) = est;
    estnaive(placeat) = estwas;
    trueatloc(placeat) = trueval;
    locmaxindices(placeat) = top_lm_indices;
    
    %Below 20 is the number of peaks
    if type == 0
        [ est, trueval, top_lm_indices ] = indepsplit( data, 20, ImgMeanorMos, subject_mask);
    elseif type == 1
        [ est, trueval, top_lm_indices ] = tindepsplit( data, 20, ImgMeanorMos, smooth_var, subject_mask);
    elseif type == 2
        [ est, trueval, top_lm_indices ] = glmindepsplit( xvar', data, 20, ImgMeanorMos, subject_mask );
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

A = [simulation', peaks', estboot', estnaive', trueatloc', locmaxindices', estis', trueatlocis', locationis'];
A = A((Jcurrent*npeaks+1):Jmax*npeaks,:);
%Save data

if type == 2
    writecsv(A, 6, header, jgit('/Results/'), strcat(filestart,'Data.csv'), append)
else
    writecsv(A, 3, header, jgit('/Results/'), strcat(filestart,'Data.csv'), append)
end

end

