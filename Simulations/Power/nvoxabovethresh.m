function [ out ] = nvoxabovethresh( type, nsubj )
% nvoxabovethresh( type, nsubj ) runs the simulations to calculate the
% number of voxels that lie above a given threshold.
%--------------------------------------------------------------------------
% ARGUMENTS
% 
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% 
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.

if strcmp(type, 'tstat') || strcmp(type, 't')
    type = 1;
%     Mag = [1, repmat(0.5, 1, 8)];
    Mag = repmat(effectsize, 1, 9);
    Rad = 10;
    Sig = gensig( Mag, Rad, 6, stdsize, {[45.5, 54.5, 45.5], [20,20,20], [71,20,20], [20,20,71], [20,89,20], [71,89,20], [71,20, 71], [20, 89, 71], [71, 89, 71]} );
    sd_str = num2str(std_dev);
elseif strcmp(type, 'R2') 
    type = 2;
%     Mag = 0.5822*ones(1, 9);
    beta = sqrt(effectsize/(1-effectsize)); %effectsize should be inputted in R^2!
    Mag = beta*ones(1, 9);
    Rad = 10;
    Sig = gensig( Mag, Rad, 6, stdsize, {[45.5, 54.5, 45.5], [20,20,20], [71,20,20], [20,20,71], [20,89,20], [71,89,20], [71,20, 71], [20, 89, 71], [71, 89, 71]} );
    contrast = [0,1];
    true_f2 = Sig.^2;
    true_R2 = true_f2./(1+true_f2);
    true_R2 = true_R2(:)';
    sd_str = num2str(std_dev);
end
Sig = Sig(:)';

global server_dir
server_addon = [server_dir, 'SIbootstrap/Simulations/'];

load([server_addon,'Thresholds/store_thresh_nsubj.mat'])
if type == 1
    store_thresh_mate = tstat_thresholds(nsubj-1);
    threshold = store_thresh_mate(FWHM_index,2);
    store_thresh_mate = tstat_thresholds(nsubj/2-1);
    threshold_is = store_thresh_mate(FWHM_index,2);
elseif type >= 2
    p = 2;
    store_thresh_mate = Fstat_thresholds(nsubj-p);
    threshold = store_thresh_mate(FWHM_index,2);
    store_thresh_mate = Fstat_thresholds(nsubj/2-p);
    threshold_is = store_thresh_mate(FWHM_index,2);
end

end

