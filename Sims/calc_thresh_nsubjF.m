run = str2num(getenv('SGE_TASK_ID'));

niters = 5000;
FWHM = 3;

df = run*5 - 2; %We're aiming for 20 runs so the df goes up to 99.

max_dist = simthresh( [1, df], FWHM, niters, 'F' );
save(jgit(['Sims/maxdists/F/df',num2str(df), 'F', num2str(FWHM), 'FWHM']), 'max_dist')
%% To initialize (must be done a priori).
% max_dist = zeros(13, 5000);
% for df = [8,18,23,48]
%     save(jgit(['Sims/maxdists/SampleSize',num2str(df), 'F']), 'max_dist')
% end