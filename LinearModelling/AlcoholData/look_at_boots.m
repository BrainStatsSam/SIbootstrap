clear
global CSI
vbm_mask = imgload('vbm_mask001').*imgload('MNImask');
alcohol_R2 = imgload('alcohol_R2');
B = 100;
bias_est_R2 = zeros(1, B);
max_loc  = zeros(1,B);
for b = 1:B
   bootR2 = imgload(['Alcohol_Boots/', 'R2_boot',num2str(b)]);
   max_loc(b) = lmindices(bootR2, 1, vbm_mask);
   bootR2(max_loc(b)) - alcohol_R2(max_loc(b));
   bias_est_R2(b) = bootR2(max_loc(b)) - alcohol_R2(max_loc(b));
end
mean(bias_est_R2)
max(alcohol_R2(323278)) - mean(bias_est_R2)

%%
clear
B = 9;
max_loc  = zeros(1,B);
vbm_mask = imgload('vbm_mask001').*imgload('MNImask');
alcohol_R2 = imgload('alcohol_R2');
for b = 1:B
   bootR2 = imgload(['Alcohol_Boots/', 'R2_boot',num2str(b)]);
   max_loc(b) = lmindices(bootR2, 1, vbm_mask);
   max_loc
   bootR2(max_loc(b)) - alcohol_R2(max_loc(b))
end

for I = 1:B
    I
    convind(max_loc(I),1)
end
%%
large_ones = find(bias_est_R2 > 0.4);
for I = 1:length(large_ones)
    large_ones(I)
    bias_est_R2(large_ones(I))
    convind(max_loc(large_ones(I)), 1)
end
%%
bias_est = 0;
alcohol_tstat = imgload('alcohol_tstat');
for b = 1:B
   boot_t = imgload(['Alcohol_Boots/', 't_boot',num2str(b)]);
   max_loc = lmindices(boot_t, 1, vbm_mask);
   boot_t(max_loc) - alcohol_tstat(max_loc)
   bias_est = boot_t(max_loc) - alcohol_tstat(max_loc) + bias_est;
end
bias_est/B


%%
mask = imgload('vbm_mask01');
threshold = 4.514;
alcohol_tstat = imgload('alcohol_tstat');
mask_of_greater_than_threshold = tstat > threshold;
mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;
top = numOfConComps(mask_of_greater_than_threshold, 0.5, 3);

top_lm_indices = lmindices(alcohol_tstat,top, mask)
convind(top_lm_indices(1), 1)
convind(top_lm_indices(2), 1)

%%
vbm_mask = imgload('vbm_mask001');
alcohol_R2 = imgload('alcohol_R2');
lmindices(alcohol_R2, 1, vbm_mask)
convind(323278,1)
alcohol_R2(323278)
