function calcests(type, groupsize, Jmax, B )
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
% calcests('vbmage', 50, Jmax)
%--------------------------------------------------------------------------
% SEE ALSO
%
if nargin < 1
    type = 0; %Meaning that the normal mean is targetted not the t-img.
end
if nargin < 2
    groupsize = 20;
end
if nargin < 3
    error('Jmax undefined!')
end
if nargin < 4
    B = 50;
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
elseif strcmp(type, 'vbmsex') || strcmp(type, 'sexvbm')
    type = 3;
elseif strcmp(type, 'vbmage') || strcmp(type, 'agevbm')
    type = 4;
end

%Ensure that Jmax isn't too high!
if Jmax > floor(4945/groupsize)
    error('Jmax is too high!')
end


nSubj = groupsize;
nVox = 91*109*91;

%Set up file processing stuff.
if type == 0
    filestart = strcat('mean','B', num2str(B), 'nsubj',num2str(nSubj));
elseif type == 1
    filestart = strcat('tstat', 'B', num2str(B), 'nsubj',num2str(nSubj));
    if smooth_var == 1
        filestart = strcat('smooth', filestart);
    end
elseif type == 2
    filestart = strcat('glmsex', 'B', num2str(B), 'nsubj',num2str(nSubj));
elseif type == 3
    filestart = strcat('vbmsex', 'B', num2str(B), 'nsubj',num2str(nSubj));
elseif type == 4
    filestart = strcat('vbmage', 'B', num2str(B), 'nsubj',num2str(nSubj));
end

%Test is some progress has already been made in which case continue the
%progress!
try
    temp = load(strcat(jgit('/Results/'), filestart,'Data'));
    currentdata = temp.A;
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
elseif type == 3
    ImgMeanorMos = imgload('vbm_sexlm_R2sex');
    Sexvar = bbvars( 'Sex', 0 );
elseif type == 4
    ImgMeanorMos = imgload('vbm_agelm_R2age');
    Agevar = bbvars( 'Age', 0 );
end
Sig = ImgMeanorMos(:)';

if type < 2
    npeaks = 20;
else
    npeaks = 3;
end

MNImask = imgload('MNImask');
global stdsize

nentries_stored = 0;

for J = Jcurrent:(Jmax-1)
    subject_mask = ones(stdsize);
    
    disp(J + 1)
    
    data = zeros([nSubj, nVox]);
    if type < 3
        for I = 1:nSubj
            img = readimg(I+J*groupsize);
            subject_mask = subject_mask.*readimg(I+J*groupsize, 'mask');
            data(I,:) = img(:);
        end
        subject_mask = subject_mask.*MNImask;
    else %do vbm stuff
        subject_mask = imgload('vbm_mask01');
        for I = 1:nSubj
            img = readvbm(I+J*groupsize);
%             subject_mask = subject_mask.*(img ~= 0); Perhaps something to
%             introduce later!
            data(I,:) = img(:);
        end
    end
    
    if type == 0
        [ estR2 , estwas, trueval, top_lm_indices ] = lmbias(1, npeaks, B, data, Sig, subject_mask);
    elseif type == 1
        [ estR2 , estwas, trueval, top_lm_indices ] = tbias(1, npeaks, B, data, Sig, smooth_var, subject_mask);
    elseif type == 2 || type == 3
        xvar = Sexvar(1+J*groupsize:(J+1)*(groupsize));
        [ estR2 , estR2viat, estwas, trueval, top_lm_indices ] = glmbias(1, npeaks, B, xvar', data, Sig, subject_mask);
    elseif type == 4
        xvar = Agevar(1+J*groupsize:(J+1)*(groupsize));
        [ estR2 , estR2viat, estwas, trueval, top_lm_indices ] = glmbias(1, npeaks, B, xvar', data, Sig, subject_mask);
        estwas - estR2
    end
    where2store = (nentries_stored + 1):(nentries_stored + npeaks);
    
    simulation(where2store) = repmat((J+1), npeaks, 1);
    peaks(where2store) = 1:npeaks;
    estboot(where2store) = estR2;
    estbootviat(where2store) = estR2viat;
    estnaive(where2store) = estwas;
    trueatloc(where2store) = trueval;
    locmaxindices(where2store) = top_lm_indices;
    
    %Below 20 is the number of peaks
    if type == 0
        [ estR2, trueval, top_lm_indices ] = indepsplit( data, npeaks, ImgMeanorMos, subject_mask);
    elseif type == 1
        [ estR2, trueval, top_lm_indices ] = tindepsplit( data, npeaks, ImgMeanorMos, smooth_var, subject_mask);
    elseif type > 2
        [ estR2, trueval, top_lm_indices ] = glmindepsplit( xvar', data, npeaks, ImgMeanorMos, subject_mask );
    end
    estis(where2store) = estR2;
    trueatlocis(where2store) = trueval;
    locationis(where2store) = top_lm_indices;
    
    nentries_stored = nentries_stored + npeaks;
end

A = [simulation', peaks', estboot', estbootviat', estnaive', trueatloc', locmaxindices', estis', trueatlocis', locationis'];

if Jcurrent > 0
    A = [currentdata; A]; %#ok<NASGU>
end

save(strcat(jgit('/Results/'), filestart,'Data'), 'A');

end

