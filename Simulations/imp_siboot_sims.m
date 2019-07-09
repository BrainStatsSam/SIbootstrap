function imp_siboot_sims( nsubj, type, stddev_setting, sim_tot )
% IMP_SIBOOT_SIMS( nsubj, type, effectsizescale ) implements the
% simulations for the SIbootstrap paper.
%--------------------------------------------------------------------------
% ARGUMENTS
% nsubj             the number of subjects
% type              the type either T, R2, t4lm or mean
% effectsizescale   the factor with which to scale the effect sizes
% sim_tot           the total number of iterations
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 4
    sim_tot = 1000;
end
std_dev = 1;
B = 100;
FWHM = 3;

R2_vec = 0.05:0.05:0.35;
CD_vec = zeros(1, length(R2_vec));
for I = 1:length(R2_vec)
    CD_vec(I) = matchsimspowerR22CD( R2_vec(I) );
end
sigma_vec = repmat(0.5,1, length(CD_vec))./CD_vec;

for Jmax = 1:sim_tot
    calcests_sims_thresh(type, nsubj, Jmax, FWHM, std_dev, B)
end

end

