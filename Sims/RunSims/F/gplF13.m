nsubj = 40;
std_dev = 1;
B = 100;
type = 'R2';

FWHM = 6;
for Jmax = 1:1000
    calcests_sims_thresh2(type, nsubj, Jmax, FWHM, std_dev, B, 1)
end