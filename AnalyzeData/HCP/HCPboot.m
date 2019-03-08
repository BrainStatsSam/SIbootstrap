global davenpor
mask = spm_read_vols(spm_vol([davenpor,'/ProjectData/HCP/HCPmask.nii']));

nsubs = 80;
% for type = {'EMOTION', 'MOTOR', 'WM', 'GAMBLING'}
for type = {'WM'}
    data = zeros([nsubs, prod(stdsize)]);
    for I = 1:nsubs
        data(I, :) = readHCP(I, type{1}, 1);
    end
    threshold = perm_thresh(data)
    %The above gives 5.1034. (This does seem rather low ngl).
    [ mos_est, naiveest, trueval, top_lm_indices ] = tbias_thresh(1, 5000, data, mask, threshold);
    %Gives a threshold of 5.7434 for WM.
    out.mos_est = mos_est/nctcorrection(80);
    out.naiveest = naiveest;
    out.top_lm_indices = top_lm_indices;
    bootstore.(type{1}) = out;
end
% EMOTION_boot = bootstore.('EMOTION');
% MOTOR_boot = bootstore.('MOTOR');
WM_boot = bootstore.('WM');
% GAMBLING_boot = bootstore.('GAMBLING');
save([davenpor,'ProjectData/HCP/boot'], 'WM_boot', 'threshold')
load([davenpor,'ProjectData/HCP/boot'])
%%

% mask = spm_read_vols(spm_vol('/data/fireback/davenpor/davenpor/ProjectData/HCP/HCPmask.nii'));
% 
% nsubs = 80;
% for type = {'EMOTION', 'MOTOR', 'WM', 'GAMBLING'}
%     data = zeros([nsubs, prod(stdsize)]);
%     for I = 1:nsubs
%         data(I, :) = readHCP(I, type{1}, 1);
%     end
%     [ mos_est, naiveest, trueval, top_lm_indices ] = tbias_thresh(1, 5000, data, mask);
%     %Gives a threshold of 5.7434 for WM.
%     out.mos_est = mos_est/nctcorrection(80);
%     out.naiveest = naiveest;
%     out.top_lm_indices = top_lm_indices;
%     bootstore.(type{1}) = out;
% end
% EMOTION_boot = bootstore.('EMOTION');
% MOTOR_boot = bootstore.('MOTOR');
% WM_boot = bootstore.('WM');
% GAMBLING_boot = bootstore.('GAMBLING');
% save('/data/fireback/davenpor/davenpor/ProjectData/HCP/boot', 'EMOTION_boot', 'MOTOR_boot', 'WM_boot', 'GAMBLING_boot')

%%
% t4lm version
mask = spm_read_vols(spm_vol([davenpor,'/ProjectData/HCP/HCPmask.nii']));

nsubs = 80;
threshold = 5.1034; %(Derived via permutation)
% for type = {'EMOTION', 'MOTOR', 'WM', 'GAMBLING'}
for type = {'WM'}
    data = zeros([nsubs, prod(stdsize)]);
    for I = 1:nsubs
        data(I, :) = readHCP(I, type{1}, 1);
    end
    [ mean_est, naiveest, trueval, top_lm_indices ] = t4lmbias(1, 5000, data, mask, threshold);
    %Gives a threshold of 5.7434 for WM.
    out.mean_est = mean_est/nctcorrection(80);
    out.naiveest = naiveest;
    out.top_lm_indices = top_lm_indices;
    bootstore.(type{1}) = out;
end
% EMOTION_boot = bootstore.('EMOTION');
% MOTOR_boot = bootstore.('MOTOR');
WM_boot = bootstore.('WM');
% GAMBLING_boot = bootstore.('GAMBLING');
% save('/data/fireback/davenpor/davenpor/ProjectData/HCP/t4lm_boot', 'EMOTION_boot', 'MOTOR_boot', 'WM_boot', 'GAMBLING_boot')
save([davenpor,'ProjectData/HCP/t4lm_boot'], 'WM_boot')

%%
segmented_mask = imgload('/data/fireback/davenpor/davenpor/ProjectData/HCP/HarvardOxford-cort-maxprob-thr0-2mm.nii.gz');
mfg_mask = (segmented_mask == 4);
imgsave(mfg_mask, 'mfg_mask', '/data/fireback/davenpor/davenpor/ProjectData/HCP/')

%%
temp = load([davenpor,'ProjectData/HCP/boot']);
temp2 = load([davenpor,'ProjectData/HCP/t4lm_boot100']);
mfg_mask = imgload([davenpor,'ProjectData/HCP/mfg_mask.nii']);
mos_est = temp.WM_boot.mos_est;
naive_est = temp.WM_boot.naiveest;
toplminds = temp.WM_boot.top_lm_indices;
mean_est = temp2.WM_boot.mos_est;
naive_est_mean = temp2.WM_boot.naiveest;
toplminds_mean = temp2.WM_boot.top_lm_indices;

% isequal(toplminds_mean, toplminds)

J = 0;
for I = 1:length(mos_est)
    loc = convind(toplminds(I));
    if mfg_mask(loc(1), loc(2), loc(3)) == 1
        J = J + 1;
        inds_in_mfg(J) = I; %Goes through all of the peaks and if it finds one in the mfg it adds it to the list.
    end
end

nens = 10;

mate2write = zeros(nens, 7);
mate2write(:, 1) = mos_est(inds_in_mfg(1:nens));
mate2write(:, 2) = naive_est(inds_in_mfg(1:nens));
mate2write(:, 3) = mean_est(inds_in_mfg(1:nens))/100
mate2write(:, 4) = naive_est_mean(inds_in_mfg(1:nens))/100

for I = 1:nens
    mate2write(I, 5:7) = convind(toplminds(inds_in_mfg(I)), 2);
end

global writeups
writecsv(mate2write, [3,3,3,3, 0,0,0], 'mosest, naiveest, meanest, naiveestmean, locindone, locindtwo, locindthree', [writeups, 'SelectiveInference/Data/'], 'HCPbootWMdata.csv')

%%
temp = load('/data/fireback/davenpor/davenpor/ProjectData/HCP/boot');
mos_est = temp.GAMBLING_boot.mos_est;
naive_est = temp.GAMBLING_boot.naiveest;
toplminds = temp.GAMBLING_boot.top_lm_indices;

