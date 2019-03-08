alcohol_mask = imgload('alcohol_mask.nii.gz');
bootR2 = imgload('alcohol_testing/boot_R2');
R2 = imgload('alcohol_testing/actual_R2');

convind(lmindices(bootR2, 1, alcohol_mask), 1)
convind(lmindices(R2, 1, alcohol_mask), 1)

t = imgload('alcohol_testing/alc_tstat');
boot_t = imgload('alcohol_testing/alc_tstat_boot');

max(t(:))
max(boot_t(:))