function [bootnaive_ests, is_ests, r_ests, r_ests_is] = loadres_thresh(type, groupsize, masktype, B, use_rft)
% LOADRES_THRES(type, groupsize, B) loads in the data corresponding to the
% thresholded estimates.
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
% M = loadres('tstat',20)
%--------------------------------------------------------------------------
if nargin < 1
    type = 'smootht';
end
if nargin < 2
   	groupsize = 20;
end
if nargin < 3
     masktype = '01';
end     
if nargin < 4
    B = 100;
end
if nargin < 5
    use_rft = 1;
end

% masktype
if strcmp(masktype, '01')
    masktype = 'vbm_mask01';
elseif strcmp(masktype, '001')
    masktype = 'vbm_mask001';
end
% type
if strcmp(type, 'mean')
    filending = strcat('Results/mean','B',num2str(B),'nsubj',num2str(groupsize),'Thresh');
elseif strcmp(type, 't') || strcmp(type, 'tstat')
    filending = strcat('Results/tstat','B',num2str(B),'nsubj',num2str(groupsize),'Thresh');
elseif strcmp(type, 't4lm')
    filending = strcat('Results/t4lm','B',num2str(B),'nsubj',num2str(groupsize),'Thresh');
elseif length(type) > 6 && length(type) < 8 && strcmp(type(1:6), 'vbmage')
    if use_rft == 1
        filending = strcat('Results/vbmage','B',num2str(B),'nsubj',num2str(groupsize),'Thresh',masktype);
    else
        filending = strcat('Results/vbmage','B',num2str(B),'nsubj',num2str(groupsize),'Thresh_noRFT',masktype);
    end
elseif length(type) > 8 && strcmp(type(1:9), 'vbmagesex')
    if use_rft == 1
        filending = strcat('Results/vbmagesex','B',num2str(B),'nsubj',num2str(groupsize),'Thresh',masktype);
    else
        filending = strcat('Results/vbmagesex','B',num2str(B),'nsubj',num2str(groupsize),'Thresh_noRFT',masktype);
    end
end

if length(type) < 6 && use_rft == 0
    filending = [filending,'_noRFT'];
end
filending = [filending, '.mat'];

try
    M = load(jgit(filending));
catch
    filending
    error('You don''t have that set of variables stored or there are extra commas!')
end
jgit(filending)
bootnaive_ests = M.A;
is_ests = M.B;
try
    r_ests = M.C;
    r_ests_is = M.D;
catch
    r_ests = NaN;
    r_ests_is = NaN;
end

end

