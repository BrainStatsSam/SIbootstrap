FWHM_set = num2cell(0:0.5:6);
nsubj = 20;
std_dev = 1;
B = 100;
type = 'R2';

parfor J = 1:6
    FWHM = FWHM_set{J};
    for Jmax = 1:1000
        calcests_sims_thresh(type, nsubj, Jmax, FWHM, std_dev, B)
    end
end

% %%
% Jmax = 1;
% parfor J = 1:6
%     FWHM = FWHM_set{J};
%     calcests_sims_thresh(type, nsubj, Jmax, FWHM, std_dev, 1)
% end
