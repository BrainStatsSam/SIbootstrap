FWHM = 5.5;
nsubj = 50;
std_dev = 1;
B = 100;
type = 'R2';

for Jmax = 1:1000
    calcests_sims_thresh(type, nsubj, Jmax, FWHM, std_dev, B, 1)
end
