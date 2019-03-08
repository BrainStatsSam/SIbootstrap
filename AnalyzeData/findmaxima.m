truth = imgload('fullmos');

truth_max = lmindices(truth,4);
for I = 1:length(truth_max)
   convind(truth_max(I), 2) 
end

truth(truth_max)

%%

img = imgload('14th50mean');
max_ind = lmindices(img,20);
img(max_ind)
for I = 1:length(max_ind)
   convind(max_ind(I)) 
end

%%
truth = imgload('smooth_vbm_agelm_R2age');
vbm_mask = imgload('vbm_mask');

truth_max = lmindices(truth,5,vbm_mask);
for I = 1:length(truth_max)
   convind(truth_max(I), 1) 
end

truth(truth_max)