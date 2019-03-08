tstat = imgload('alcohol_tstat');
mask = imgload('alcohol_mask.nii.gz', 1);

sum(tstat(:) > 4.514)

indices = lmindices(tstat, 3, mask);

for I = 1:length(indices)
    tstat(indices(I))
   convind(indices(I), 1) 
end