run = str2num(getenv('SGE_TASK_ID'));

FWHM_set = num2cell(0:0.5:6);
std_dev = 1;

if run <= 13
    type = 'tstat';
    nsubj = 20;
elseif run <= 26
    type = 'tstat';
    nsubj = 50;
elseif run <= 39
    type = 't4lm';
    nsubj = 20;
elseif run <= 52
    type = 't4lm';
    nsubj = 50;
end
% elseif run <= 65
%     type = 'R2';
%     nsubj = 20;
% elseif run <= 78
%     type = 'R2';
%     nsubj = 50;
% end

which_FWHM_index = mod(run, 13) + 1;
FWHM = FWHM_set{which_FWHM_index};
B = 100;

for Jmax = 1:1000
    calcests_sims_thresh(type, nsubj, Jmax, FWHM, std_dev, B)
end