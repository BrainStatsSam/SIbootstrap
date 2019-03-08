run = str2num(getenv('SGE_TASK_ID'));

FWHM_set = num2cell(0:0.5:6);
std_dev = 1;

if run <= 13
    type = 'R2';
    nsubj = 20;
else
    type = 'R2';
    nsubj = 50;
end

which_FWHM_index = mod(run, 13) + 1;
FWHM = FWHM_set{which_FWHM_index};
B = 100;

for Jmax = 1:1000
    calcests_sims_thresh(type, nsubj, Jmax, FWHM, std_dev, B)
end

%%
type = 'R2';
nsubj = 20;
Jmax = 1;
FWHM = 0;
std_dev = 1;
B = 1;
calcests_sims_thresh(type, nsubj, Jmax, FWHM, std_dev, B)