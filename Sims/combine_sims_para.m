niters = 5000;

df_vec = [8,18,23,48];

for df_index = 1:4
    max_dist = zeros(13, niters);
    for FWHM = 1:13
        temp = load(jgit(['Sims/maxdists/SampleSize',num2str(df), 'F', num2str(which_FWHM_index), 'FWHM']));
        max_dist(FWHM, :) = temp.max_dist;
    end
    save(jgit(['Sims/maxdists/SampleSize',num2str(df), 'F']), 'max_dist')
end
        
        
    
    
    
    