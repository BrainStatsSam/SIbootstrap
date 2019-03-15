nsubj = 10;
std_dev = 1;
B = 100;
type = 'R2';

FWHM = 3;

for Jmax = 1:1000
    calcests_sims_thresh2(type, nsubj, Jmax, FWHM, std_dev, B)
end