global davenpor
WM_tstat = imgload([davenpor, 'ProjectData/HCP/WM_tstat.nii']);
WM_mask = imgload([davenpor, 'ProjectData/HCP/WM_mask.nii']);

max_loc = lmindices(WM_tstat, 1, WM_mask);
WM_tstat(max_loc)

convind(max_loc, 1)
convind(max_loc, 2)

%%
format long
1-tcdf(5.10, 79)

1-tcdf(5.73, 79)

