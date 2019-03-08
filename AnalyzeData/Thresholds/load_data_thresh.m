function threshold = load_data_thresh( type, groupsize, vbmmask, alpha )
% LOAD_DATA_THRESH( groupsize, FWHM ) loads the alpha level threshold for 
% the t-statistic generatated from groupsize subject stored simulated null 
% data on the maxima.
%--------------------------------------------------------------------------
% ARGUMENTS
% groupsize     The number of subjects in each group. (The tstat degrees of
% freedom is one less than this in 
% FWHM          The FWHM of the data.
% alpha         The alpha level for the maxima. Default: 0.05.
%--------------------------------------------------------------------------
% OUTPUT
% threshold     The alpha level threshold on the maxima.
%--------------------------------------------------------------------------
% EXAMPLES
% load_data_thresh( 'tstat', 20 )
% load_data_thresh( 'vbmagesex', 100 )
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 3
    vbmmask = 'vbm001';
end
if nargin < 5
    alpha = 0.05;
end

if strcmp(type, 't') ||  strcmp(type, 'tstat')
    filename = ['max_dist_',num2str(groupsize),'.mat'];
elseif strcmp(type, 'vbmage')
    filename = [vbmmask, '_max_dist_',num2str(groupsize),'.mat'];
elseif strcmp(type, 'vbmagesex')
    filename = ['vbmagesex_',vbmmask(4:end), '_max_dist_',num2str(groupsize),'.mat'];
end

filestart = jgit(['AnalyzeData/Thresholds/', filename]);
if 0 == exist(filestart, 'file');
    error('This file does not exist yet.')
else
    temp = load(filestart);
end

if strcmp(type, 't') ||  strcmp(type, 'tstat')
    max_dist_vec = temp.max_dist;
elseif strcmp(type, 'vbmage')
    if strcmp(vbmmask, 'vbm001')
        max_dist_vec = temp.max_dist_001;
    else
        max_dist_vec = temp.max_dist_01;
    end
elseif strcmp(type, 'vbmagesex')
    if strcmp(vbmmask, 'vbm001') || strcmp(vbmmask, 'vbm_mask001')
        max_dist_vec = temp.max_dist_001;
    elseif strcmp(vbmmask, 'vbm01') || strcmp(vbmmask, 'vbm_mask01')
        max_dist_vec = temp.max_dist_01;
    end
end

threshold = prctile(max_dist_vec, 100*(1-alpha));

end

