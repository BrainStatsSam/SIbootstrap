%% For real data
for groupsize = [20,50,100]
    [A,B] = loadres_thresh('t', groupsize);
    
    boot_ests = A(:,3);
    fprintf('boot/circular\n')
    sum(~isnan(boot_ests))
    sum(~isnan(boot_ests))/floor(4940/groupsize)
    
    fprintf('is\n')
    is_ests = B(:,3);
    sum(~isnan(is_ests))
    sum(~isnan(is_ests))/floor(4940/groupsize)
end

%% For simulations
for groupsize = [20,50]
    for FWHM = 0:0.5:6;
        out = dispres_sims_thresh('tstat', groupsize, 1, FWHM, 0 , 0);
        boot_ests = out.biasboot;
        fprintf('boot/circular\n')
        sum(~isnan(boot_ests))
        sum(~isnan(boot_ests))/floor(4940/groupsize)
        
        fprintf('is\n')
        is_ests = out.biasis;
        sum(~isnan(is_ests))
        sum(~isnan(is_ests))/floor(4940/groupsize)
    end
end