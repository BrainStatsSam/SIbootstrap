X = readX;
c = zeros(1,16);
c(2) = -1;
alcohol_data = imgload('/home/fs0/topiwala/scratch/vbm527/stats/GM_mod_merg_s3.nii.gz');

data = zeros(527, 91*109*91);
for I = 1:527 
    img = alcohol_data(:,:,:,I);
    data(I, :) = img(:);
end

out = MVlm_multivar(X, data, c, 0);
imgsave(out.t, 'alcohol_tstat' )

% randomise -i GM_mod_merg_s3 -m GM_mask -o tom -d avalcoholfull16.mat -t avalcoholfull16.con -T -n 500 -x
% 
% -i Input 4D data
% -m MASK
% -o Output
% -d Design Matrix
% -t Contrast file