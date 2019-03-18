nsubj = 90;
std_dev = 1;
B = 100;
type = 'R2';

FWHM = 6;

for Jmax = 1:1000
    calcests_sims_thresh2(type, nsubj, Jmax, FWHM, std_dev, B)
end

% %%
% Jmax = 1;
% parfor J = 1:6
%     FWHM = FWHM_set{J};
%     calcests_sims_thresh(type, nsubj, Jmax, FWHM, std_dev, 1)
% end
