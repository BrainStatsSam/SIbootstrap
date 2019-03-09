function calcests_sims_thresh(type, groupsize, Jmax, FWHM, std_dev, B, use_para, six32 )
% CALCESTS_SIMS_THRESH(type, groupsize, Jmax, FWHM, std_dev, B, six32)
% returns the estimates obtained under bootstrapping.
%--------------------------------------------------------------------------
% ARGUMENTS
% B         the number of bootstrap iterations.
% groupsize the size of the groups of subjects to test.
% Jmax      the total number of groups to test. Note that there are of
%           course contraints on this because of the amount of data.
%           Error checking for this is included.
% type      Either mean, tstat or smoothtstat or glmsex
% use_para  0/1, specifies whether to parallelize the bootstrap part.
%           Default is 0 ie not to.
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport
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
    FWHM = 6;
end
if nargin < 5
    std_dev = 1;
end
if nargin < 6
    B = 50;
end
if nargin < 7
    use_para = 0;
end
if nargin < 8
    six32 = 0;
end


global stdsize
% global SimsDir

nSubj = groupsize;
nVox = 91*109*91;

if FWHM == round(FWHM)
    fwhmstring = num2str(FWHM);
else
    fwhmasstring = num2str(FWHM);
    if FWHM > 10
        fwhmstring = strcat(fwhmasstring(1:2), 'point', fwhmasstring(4));
    else
        fwhmstring = strcat(fwhmasstring(1), 'point', fwhmasstring(3));
    end
end

if strcmp(type, 'mean')
    type = 0;
    Mag = 2;
    Rad = 10;
    Sig = gensig( Mag, Rad, 6, stdsize );
    filestart = strcat('meanThresh/','B', num2str(B),'sd',num2str(std_dev),'FWHM', fwhmstring,'nsubj',num2str(nSubj),'SIMS');
elseif strcmp(type, 'mean2')
    type = 0;
    Mag = [2,4,4];
    Rad = 10;
    Sig = gensig( Mag, Rad, 6, stdsize, {[20,30,20], [40,70,40], [40, 70,70]} );
    filestart = strcat('mean2Thresh/','B', num2str(B),'sd',num2str(std_dev),'FWHM', fwhmstring,'nsubj',num2str(nSubj),'SIMS','version2');
elseif strcmp(type, 'tstat') || strcmp(type, 't')
    type = 1;
%     Mag = 0.75*ones(1, 9);
    Mag = [1, repmat(0.5, 1, 8)];
    Rad = 10;
    Sig = gensig( Mag, Rad, 6, stdsize, {[45.5, 54.5, 45.5], [20,20,20], [71,20,20], [20,20,71], [20,89,20], [71,89,20], [71,20, 71], [20, 89, 71], [71, 89, 71]} );
    smooth_var = 0;
elseif strcmp(type, 'smoothtstat') || strcmp(type, 'smootht')
    type = 1;
    smooth_var = 1;
elseif strcmp(type, 't4lm')
    type = -1;
    Mag = [1, repmat(0.5, 1, 8)];
    Rad = 10;
    Sig = gensig( Mag, Rad, 6, stdsize, {[45.5, 54.5, 45.5], [20,20,20], [71,20,20], [20,20,71], [20,89,20], [71,89,20], [71,20, 71], [20, 89, 71], [71, 89, 71]} );
    smooth_var = 0;
    filestart = strcat('t4lmThresh/','B', num2str(B),'sd',num2str(std_dev),'FWHM', fwhmstring, 'nsubj',num2str(nSubj),'SIMS');
elseif strcmp(type, 'R2') || strcmp(type, 'R2')
    type = 2;
    Mag = 0.5822*ones(1, 9);
    Rad = 10;
    Sig = gensig( Mag, Rad, 6, stdsize, {[45.5, 54.5, 45.5], [20,20,20], [71,20,20], [20,20,71], [20,89,20], [71,89,20], [71,20, 71], [20, 89, 71], [71, 89, 71]} );
    contrast = [0,1];
    true_f2 = Sig.^2;
    true_R2 = true_f2./(1+true_f2);
    true_R2 = true_R2(:)';
end

%Set up file processing stuff.
if type == 1
    filestart = strcat('tstatThresh/','B', num2str(B),'sd',num2str(std_dev),'FWHM', fwhmstring, 'nsubj',num2str(nSubj),'SIMS');
    if smooth_var == 1
        filestart = strcat('smooth', filestart);
    end
elseif type == 2
    filestart = strcat('R2Thresh/','B', num2str(B),'sd',num2str(std_dev),'FWHM', fwhmstring, 'nsubj',num2str(nSubj),'SIMS');
end
if six32
    filestart = strcat('632', filestart);
end
Sig = Sig(:)';

%Test is some progress has already been made in which case continue the progress!
try
    temp = load(jgit(['Sims/', filestart]));
    currentdataA = temp.A;
    currentdataB = temp.B;
    %     Jcurrent = currentdataA(:,1);
    %     Jcurrent = Jcurrent(end);
    Jcurrent = temp.Jmax;
catch
    Jcurrent = 0;
end

if Jcurrent >= Jmax
    return
end

subject_mask = ones(stdsize);
nentries_stored = 0;
nentries_stored_is = 0;

load('/data/greyplover/not-backed-up/oxwasp/oxwasp16/davenpor/SIbootstrap/Sims/store_thresh.mat')
try
    FWHM_index = find(0:0.5:6 == FWHM);
catch
    error('There is no threshold stored for this choice of FWHM')
end
%This loads the thresholds.
if type == 1 || type == -1 
    store_thresh_mate = tstat_thresholds(groupsize-1);
    threshold = store_thresh_mate(FWHM_index,2);
    store_thresh_mate = tstat_thresholds(groupsize/2-1);
    threshold_is = store_thresh_mate(FWHM_index,2);
elseif type >= 2
    p = 2;
    store_thresh_mate = Fstat_thresholds(groupsize-p);
    threshold = store_thresh_mate(FWHM_index,2);
    store_thresh_mate = Fstat_thresholds(groupsize/2-p);
    threshold_is = store_thresh_mate(FWHM_index,2);
end

for J = Jcurrent:(Jmax-1)
    disp(J + 1)
    
    data = zeros([nSubj, nVox]);
    if type == 0
        noise = noisegen(stdsize, nSubj, FWHM, 3 );
        for I = 1:nSubj
            data(I, :) = Sig + std_dev*noise(I,:);
        end
    elseif type == 1
        noise = noisegen(stdsize, nSubj, FWHM, 3 );
        for I = 1:nSubj
            data(I, :) = Sig + std_dev*noise(I,:);
        end
        Sig = Sig./std_dev;
    elseif type == -1
        noise = noisegen(stdsize, nSubj, FWHM, 3 );
        for I = 1:nSubj
            data(I, :) = Sig + std_dev*noise(I,:);
        end
    elseif type == 2
        noise = noisegen(stdsize, nSubj, FWHM, 3 );
        x = normrnd(0, 1, [1, nSubj])';
        for I = 1:nSubj
            data(I, :) = 1 + Sig.*x(I) + std_dev*noise(I,:);
        end
    else
        error('This type is not defined')
    end
    
    if type == -1
        [ est , estwas, trueval, top_lm_indices ] = t4lmbias(1, B, data, subject_mask, threshold, Sig );
    elseif type == 0
        threshold = 2;
        [ est , estwas, trueval, top_lm_indices ] = lmbias_thresh(1, B, data, Sig, subject_mask, threshold);
    elseif type == 1
        [ est , estwas, trueval, top_lm_indices ] = tbias_thresh(1, B, data, subject_mask, threshold, Sig, smooth_var);
    elseif type == 2
        [ est, estwas, top_lm_indices, trueval] = glmbias_thresh_multivar( 1, B, x, data, true_R2, subject_mask, contrast, threshold, 1, use_para);
    end
        
    top = length(est);
    
    where2store = (nentries_stored + 1):(nentries_stored + top);
    
    simulation(where2store) = repmat((J+1), top, 1);
    peaks(where2store) = 1:top;
    estboot(where2store) = est;
    estnaive(where2store) = estwas;
    trueatloc(where2store) = trueval;
    locmaxindices(where2store) = top_lm_indices;
    
    if type == -1
        smooth_var = 0;
        [ est, trueval, top_lm_indices ] = tindepsplit_thresh( data, reshape3D(Sig), smooth_var, subject_mask, threshold_is, 1);
    elseif type == 0
        threshold_is = 2;
        [ est, trueval, top_lm_indices ] = indepsplit_thresh( data, reshape3D(Sig), subject_mask, threshold_is);
    elseif type == 1
        [ est, trueval, top_lm_indices ] = tindepsplit_thresh( data, reshape3D(Sig), smooth_var, subject_mask, threshold_is);
    elseif type == 2
        [ est, trueval, top_lm_indices ] = glmindepsplit_thresh_multivar( x, data, true_R2, subject_mask, contrast, threshold_is);
    end
    top_is = length(est);
    where2store2 = (nentries_stored_is + 1):(nentries_stored_is + top_is);
    simulation_is(where2store2) = repmat((J+1), top_is, 1);
    peaks_is(where2store2) = 1:top_is;
    estis(where2store2) = est;
    trueatlocis(where2store2) = trueval;
    locationis(where2store2) = top_lm_indices;
    
    nentries_stored = nentries_stored + top;
    nentries_stored_is = nentries_stored_is + top_is;
end

A = [simulation', peaks', estboot', estnaive', trueatloc', locmaxindices'];
B = [simulation_is', peaks_is', estis', trueatlocis', locationis'];

if Jcurrent > 0
    A = [currentdataA; A]; %#ok<NASGU>
    B = [currentdataB; B]; %#ok<NASGU>
end

save(['/data/greyplover/not-backed-up/oxwasp/oxwasp16/davenpor/SIbootstrap/Sims/', filestart], 'A', 'B', 'Jmax');

end

