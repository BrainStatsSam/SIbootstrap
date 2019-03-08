X = readX;
c = zeros(1,16);
c(2) = -1;
alcohol_data = imgload('/home/fs0/topiwala/scratch/vbm527/stats/GM_mod_merg_s3.nii.gz');

data = zeros(527, 91*109*91);
for I = 1:527 
    img = alcohol_data(:,:,:,I);
    data(I, :) = img(:);
end
clear alcohol_data
alcohol_mask = imgload('alcohol_mask.nii.gz');

threshold = 4.514^2;
%threshold = 

[ R2est, f2est, naiveest, top_lm_indices, trueval, test, fisher_est, ~, ~, ~, ~, R_est] = glmbias_thresh_multivar( 1, 1000, X, data, NaN, alcohol_mask, c, threshold, 0);

save('/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Results/alcoholboot0.mat', 'R2est', 'f2est', 'naiveest', 'top_lm_indices', 'test', 'fisher_est', 'R_est')