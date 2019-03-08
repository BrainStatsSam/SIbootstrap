FWHM_set = num2cell(0:0.5:6);
niters = 5000;

for run = 14:26
    run
    if run <= 13
        df = 8;
    elseif run <= 26
        df = 18;
    elseif run <= 39
        df = 23;
    elseif run <= 52
        df = 48;
    end
    
    which_FWHM_index = mod(run, 13) + 1;
    
    max_dist = simthresh( [1, df], FWHM_set{which_FWHM_index}, niters, 'F' );
    save(jgit(['Sims/maxdists/SampleSize',num2str(df), 'F', num2str(which_FWHM_index), 'FWHM']), 'max_dist')
end