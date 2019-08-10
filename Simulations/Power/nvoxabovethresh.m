function [ nvox, avnvox ] = nvoxabovethresh( nsubj, nsims )
% nvoxabovethresh( type, nsubj ) runs the simulations to calculate the
% number of voxels that lie above a given threshold.
%--------------------------------------------------------------------------
% ARGUMENTS
% nsubj     the number of subjects
% nsims     the number of simulations
%--------------------------------------------------------------------------
% OUTPUT
% nvox      the number of voxels above the 0.05 voxelwise threshold across
%           all simulations
% avnvox    the average number of voxels above the 0.05 voxelwise threshold 
%           across all simulations
%--------------------------------------------------------------------------
% EXAMPLES
% 
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 2
    nsims = 1000;
end
FWHM = 3;
stdsize = [91,109,91];

% if strcmp(type, 'tstat') || strcmp(type, 't')
Mag = repmat(0.5, 1, 9); %Main simulation setting
Rad = 10;
Sig = gensig( Mag, Rad, 6, stdsize, {[45.5, 54.5, 45.5], [20,20,20], [71,20,20], [20,20,71], [20,89,20], [71,89,20], [71,20, 71], [20, 89, 71], [71, 89, 71]} );
% end
Sig = Sig(:)';

global server_dir
server_addon = [server_dir, 'SIbootstrap/Simulations/'];

load([server_addon,'Thresholds/store_thresh_nsubj.mat'])
store_thresh_mate = tstat_thresholds(nsubj-1);
threshold = store_thresh_mate(1,2); %(1,2) is the index corresponding to FWHM = 3.
std_dev = 1;

nvox = 0;
for sim = 1:nsims
    sim
    noise = noisegen(stdsize, nsubj, FWHM, 3 );
    data = zeros([nsubj, stdsize]);
    for I = 1:nsubj
        data(I, :) = Sig + std_dev*noise(I,:);
    end
    
    onesamplet = mvtstat(data);
    abovethresh = (onesamplet > threshold);
    nvox = nvox + sum(abovethresh(:));
end

avnvox = nvox/nsims;

global SIloc
save([SIloc,'Simulations/Power/nvoxstore/',num2str(nsubj)], 'nvox', 'avnvox')

end

