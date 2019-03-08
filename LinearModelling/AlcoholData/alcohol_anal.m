%% Maximizing the R2
R2 = imgload('alcohol_R2_001');
vbm_mask = imgload('vbm_mask001');
max_loc = lmindices(R2, 1, vbm_mask);

R2(max_loc)
convind(max_loc, 1)

%% Maximizing the tstat
tstat = imgload('alcohol_tstat_001');
vbm_mask = imgload('vbm_mask001');
max_loc = lmindices(tstat, 1, vbm_mask);

tstat(max_loc)
convind(max_loc, 1)
max_locs = find(tstat > 4.514)
tstat(max_locs)
for I = 1:length(max_locs)
   convind(max_locs(I), 1) 
end


%% Maximizing the tstat with no vbm masking
tstat = imgload('alcohol_tstat');
vbm_mask = imgload('vbm_mask001');
max_loc = lmindices(tstat, 1, vbm_mask);

tstat(max_loc)
convind(max_loc, 1)

%%
tstat = imgload('alcohol_tstat_mask');
alcohol_mask = imgload('alcohol_mask',0);
max_loc = lmindices(tstat, 1, alcohol_mask);