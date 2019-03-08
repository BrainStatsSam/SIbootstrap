function calcests_thresh(type, groupsize, Jmax, use_rft, B, mask_type)
% calcests_thresh calculates the estimates using thresholding.
%--------------------------------------------------------------------------
% ARGUMENTS
% type      Which algorithm to run. Only tstat for now.
% groupsize the size of the groups of subjects to test.
% Jmax      the total number of groups to test. Note that there are of
%           course contraints on this because of the amount of data.
%           Error checking for this is included.
% B         the number of bootstrap iterations.
%--------------------------------------------------------------------------
% OUTPUT
%
%--------------------------------------------------------------------------
% EXAMPLES
%
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 1
    type = 'tstat';
end
if nargin < 2
    groupsize = 20;
end
if nargin < 4
    use_rft = 0;
end
if nargin < 5
    B = 100;
end
if nargin < 6
    mask_type = 'vbm_mask001';
end

if use_rft == 1
    threshold = NaN; %So that RFT thresholding is used! No threshold is needed as the threshold is calculated individually each time.
    threshold2 = NaN;
else
    threshold = load_data_thresh( type, groupsize, mask_type);
    threshold2 = load_data_thresh( type, (groupsize/2), mask_type);
end

if Jmax > floor(4945/groupsize)
    error('Jmax is too high!')
end

if strcmp(type, 't4lm')
    type = -1;
    mask_type = '';
elseif strcmp(type, 'mean')
    type = 0;
    mask_type = '';
elseif strcmp(type, 'tstat') || strcmp(type, 't')
    type = 1;
    smooth_var = 0;
    mask_type = '';
elseif strcmp(type, 'smoothtstat') || strcmp(type, 'smootht')
    type = 1;
    smooth_var = 1;
    mask_type = '';
elseif strcmp(type, 'vbmsex')
    type = 3;
elseif strcmp(type, 'vbmage')
    type = 4;
elseif strcmp(type, 'vbmagesex')
    type = 5;
end

%Set up file processing stuff.
if type == -1
    filestart = strcat('t4lm','B', num2str(B), 'nsubj',num2str(groupsize));
elseif type == 0
    filestart = strcat('mean','B', num2str(B), 'nsubj',num2str(groupsize));
elseif type == 1
    filestart = strcat('tstat', 'B', num2str(B), 'nsubj',num2str(groupsize));
    if smooth_var == 1
        filestart = strcat('smooth', filestart);
    end
elseif type == 3
    ImgMeanorMos = imgload('vbm_sexlm_Rsex');
    Sexvar = bbvars( 'Sex', 0 );
elseif type == 4
    filestart = strcat('vbmage', 'B', num2str(B), 'nsubj',num2str(groupsize));
    ImgMeanorMos = imgload('smooth_vbm_agelm_Rage');
    Agevar = bbvars( 'Age', 0 );
    contrast = [0,1];
elseif type == 5
    filestart = strcat('vbmagesex', 'B', num2str(B), 'nsubj',num2str(groupsize));
    ImgMeanorMos = imgload('smooth_vbm_agesexlm_Rage');
    Agevar = bbvars( 'Age', 0 );
    Sexvar = bbvars( 'Sex', 0 );
    contrast = [0,0,1];
end
filestart = strcat(filestart, 'Thresh');
if ~use_rft
    filestart = strcat(filestart, '_noRFT');
end

% if type > 2 && nargin < 5
%     mask_type = 'vbm_mask01';
% end


%Test is some progress has already been made in which case continue the
%progress!
try
    temp = load(strcat(jgit('/Results/'), filestart,mask_type));
    currentdataA = temp.A;
    currentdataB = temp.B;
    %     Jcurrent = currentdataA(:,1);
    %     Jcurrent = Jcurrent(end);
    Jcurrent = temp.Jmax;
    if type >= 4
        currentdataC = temp.C;
        currentdataD = temp.D;
    end
catch
    Jcurrent = 0;
end

if Jcurrent >= Jmax
    return
end

if type <= 0
    ImgMeanorMos = imgload('fullmean');
elseif type == 1
    ImgMeanorMos = imgload('fullmos');
end
Sig = ImgMeanorMos(:)';

%Note, we're not initializing any variables here as we're unsure as to
%their size since there will be different numbers of peaks from each
%realization.

MNImask = imgload('MNImask');
global stdsize
nVox = prod(stdsize);

nentries_stored = 0;
nentries_stored_t = 0;
nentries_stored_is = 0;
nentries_stored_is_t = 0;

for J = Jcurrent:(Jmax-1)
    %Initialize subject mask.
    subject_mask = ones(stdsize);
    
    disp(J + 1)
    
    data = zeros([groupsize, nVox]);
    
    if type < 3
        for I = 1:groupsize
            img = readimg(I+J*groupsize);
            subject_mask = subject_mask.*readimg(I+J*groupsize, 'mask');
            data(I,:) = img(:);
        end
        subject_mask = subject_mask.*MNImask;
    else %do vbm stuff
        subject_mask = imgload(mask_type);
        for I = 1:groupsize
            img = readvbm(I+J*groupsize);
            data(I,:) = img(:);
        end
    end
    
    subject_mask = subject_mask.*MNImask;
    
    if type == -1
        %         threshold = load_data_thresh('t', groupsize);
        [ est , estwas, trueval, top_lm_indices ] = t4lmbias(1, B, data, subject_mask, threshold, Sig );
    elseif type == 0
        threshold = 120;
        [ est , estwas, trueval, top_lm_indices ] = lmbias_thresh(1, B, data, Sig, subject_mask, threshold);
    elseif type == 1
        %         threshold = load_data_thresh('t', groupsize);
        [ est , estwas, trueval, top_lm_indices ] = tbias_thresh(1, B, data, subject_mask, threshold, Sig, smooth_var);
    elseif type == 4
        %         threshold = load_data_thresh('vbmage', groupsize);
        xvar = Agevar(1+J*groupsize:(J+1)*(groupsize))';
        %         [ est, estf2, estwas, trueval, top_lm_indices ] = glmbias_thresh( 1, B, xvar, data, Sig, subject_mask, threshold);
        [ est, estf2, estwas, top_lm_indices, trueval, test, fisher_est, trueRattlocs, top_lm_indices_t, tnaive, fishnaive, restimate, rnaive ]  = glmbias_thresh_multivar( 1, B, xvar, data, Sig, subject_mask, contrast, threshold, 1, 1);
        truevalf2 = trueval./(1-trueval);
        estwasf2 = estwas./(1-estwas);
    elseif type == 5
        %         threshold = load_data_thresh('vbmagesex', groupsize);
        xvarage = Agevar(1+J*groupsize:(J+1)*(groupsize))';
        xvarsex = Sexvar(1+J*groupsize:(J+1)*(groupsize))';
        X = [xvarsex, xvarage];
        [ est, estf2, estwas, top_lm_indices, trueval, test, fisher_est, trueRattlocs, top_lm_indices_t, tnaive, fishnaive, restimate, rnaive ] = glmbias_thresh_multivar_all( 1, B, X, data, Sig, subject_mask, contrast, threshold, 1, 1);
        truevalf2 = trueval./(1-trueval);
        estwasf2 = estwas./(1-estwas);
    else
        error('Thresholding hasn''t been introduced for this type yet.')
    end
    top = length(est);
    
    where2store = (nentries_stored + 1):(nentries_stored + top);
    
    simulation(where2store) = repmat((J+1), top, 1);
    peaks(where2store) = 1:top;
    estboot(where2store) = est;
    if type > 3
        top_t = length(test);
        where2store_t  = (nentries_stored_t + 1):(nentries_stored_t + top_t);
        simulation_t(where2store_t) = repmat((J+1), top_t, 1);
        peaks_t(where2store_t) = 1:top_t;
        
        estf2vec(where2store) = estf2;
        estf2naive(where2store) = estwasf2;
        trueatlocf2(where2store) = truevalf2;
        
        est_t(where2store_t) = test;
        est_fisher(where2store_t) = fisher_est;
        true_t(where2store_t) = trueRattlocs;
        locmaxindices_t(where2store_t) = top_lm_indices_t;
        naive_t(where2store_t) = tnaive;
        naive_fish(where2store_t) = fishnaive;
        boot_r(where2store_t) = restimate;
        naive_r(where2store_t) = rnaive;
    end
    estnaive(where2store) = estwas;
    trueatloc(where2store) = trueval;
    locmaxindices(where2store) = top_lm_indices;
    
    if type == -1
        smooth_var = 0;
        %         threshold = load_data_thresh('t', (groupsize/2));
        [ est, trueval, top_lm_indices ] = tindepsplit_thresh( data, ImgMeanorMos, smooth_var, subject_mask, threshold2, 1);
    elseif type == 0
        % Uses the same threshold as above.
        [ est, trueval, top_lm_indices ]  = indepsplit_thresh( data, ImgMeanorMos, subject_mask, threshold2);
    elseif type == 1
        %         threshold = load_data_thresh('t', (groupsize/2));
        [ est, trueval, top_lm_indices ] = tindepsplit_thresh( data, ImgMeanorMos, smooth_var, subject_mask, threshold2);
    elseif type == 4
        %         threshold = load_data_thresh('vbmage', (groupsize/2));
        %         [ est, trueval, top_lm_indices ] = glmindepsplit_thresh( xvar, data, ImgMeanorMos, subject_mask, threshold);
        [ est, trueval, top_lm_indices, r_est, truerval ] = glmindepsplit_thresh_multivar( xvar, data, ImgMeanorMos, subject_mask, contrast, threshold2, 1, 1 );
        estf2 = est./(1-est);
        truevalf2 = trueval./(1-trueval);
    elseif type == 5
        %         threshold = load_data_thresh('vbmagesex', (groupsize/2));
        [ est, trueval, top_lm_indices, r_est, truerval, top_lm_indices_t ] = glmindepsplit_thresh_multivar_all( X, data, ImgMeanorMos, subject_mask, contrast, threshold2, 1, 1 );
        estf2 = est./(1-est);
        truevalf2 = trueval./(1-trueval);
    end
    top_is = length(est);
    where2store2 = (nentries_stored_is + 1):(nentries_stored_is + top_is);
    
    simulation_is(where2store2) = repmat((J+1), top_is, 1);
    peaks_is(where2store2) = 1:top_is;
    estis(where2store2) = est;
    if type > 3
        top_is_t = length(r_est);
        where2store2_t = (nentries_stored_is_t + 1):(nentries_stored_is_t + top_is_t);

        simulation_is_t(where2store2_t) = repmat((J+1), top_is_t, 1);
        peaks_is_t(where2store2_t) = 1:top_is_t;
        estisf2(where2store2) = estf2;
        trueatlocisf2(where2store2) = truevalf2;
        
        estis_r(where2store2_t) = r_est;
        trueatlocis_t(where2store2_t) = truerval;
        locationis_t(where2store2_t) = top_lm_indices_t;
        
        nentries_stored_t = nentries_stored_t + top_t;
        nentries_stored_is_t = nentries_stored_is_t + top_is_t;
    end
    trueatlocis(where2store2) = trueval;
    locationis(where2store2) = top_lm_indices;
    
    nentries_stored = nentries_stored + top;
    nentries_stored_is = nentries_stored_is + top_is;
end

if type < 4
    A = [simulation', peaks', estboot', estnaive', trueatloc', locmaxindices'];
    B = [simulation_is', peaks_is', estis', trueatlocis', locationis'];
else
    A = [simulation', peaks', estboot', estf2vec', estnaive', estf2naive', locmaxindices', trueatlocf2', trueatloc'];
    C = [simulation_t', peaks_t', est_t', est_fisher', true_t', naive_t', naive_fish', locmaxindices_t', boot_r', naive_r'];
    B = [simulation_is', peaks_is', estis', estisf2', trueatlocis', trueatlocisf2', locationis'];
    D = [simulation_is_t', peaks_is_t', estis_r', trueatlocis_t', locationis_t'];
end

if Jcurrent > 0
    A = [currentdataA; A]; %#ok<NASGU>
    B = [currentdataB; B]; %#ok<NASGU>
    if type >= 4
        C = [currentdataC; C]; %#ok<NASGU>
        D = [currentdataD; D]; %#ok<NASGU>
    end
end

if type < 4
    save(strcat(jgit('/Results/'), filestart,mask_type), 'A', 'B', 'Jmax');
else
    save(strcat(jgit('/Results/'), filestart,mask_type), 'A', 'B','C','D', 'Jmax');
end

end

