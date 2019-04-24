%% Code to generate Figure 6
FWHM = 3;
niters = 1000;
groupsizes = 20:10:100;
count_peaks_boot = zeros(1, length(groupsizes));
count_peaks_boot_av = zeros(1, length(groupsizes));

count_peaks_is = zeros(1, length(groupsizes));
count_peaks_is_av = zeros(1, length(groupsizes));

for I = 1:length(groupsizes)
    out = dispres_sims_thresh('tstat', groupsizes(I), FWHM, 0);
    boot_ests = out.biasboot;
    count_peaks_boot(I) = sum(~isnan(boot_ests));
    count_peaks_boot_av(I) = sum(~isnan(boot_ests))/niters;
    
    is_ests = out.biasis;
    count_peaks_is(I) = sum(~isnan(is_ests));
    count_peaks_is_av(I) = sum(~isnan(is_ests))/niters;
end

%%
plot(groupsizes, count_peaks_boot_av, 'LineWidth', 2, 'color', def_col('yellow'))
hold on
plot(groupsizes, count_peaks_is_av, 'LineWidth', 2, 'color', def_col('blue'))

title('Comparing Power')
xlabel('Sample Size')
ylabel('Average number of peaks')
legend('Bootstrap/Circular', 'Data-Splitting', 'Location', 'NorthWest')

set(gca,'fontsize', 20)