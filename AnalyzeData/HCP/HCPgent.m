global stdsize
global davenpor
nsubs = 80;
MNImask = imgload('MNImask');

% for type = {'EMOTION', 'MOTOR', 'WM', 'GAMBLING'}
for type = {'WM'}
    data = zeros([nsubs, prod(stdsize)]);
    for I = 1:nsubs
        data(I, :) = readHCP(I, type{1}, 1);
    end
    [t_statistic, ~, ~, cohensd] = mvtstat(data, 1, 0);
    typeMASK = ~isnan(t_statistic).*MNImask;
    t_statistic = nan2zero(t_statistic).*MNImask;
    cohendsd = nan2zero(cohensd).*MNImask;
    imgsave(t_statistic, [type{1}, '_tstat'], [davenpor, 'ProjectData/HCP'])
    imgsave(cohensd, [type{1}, '_cohensd'], [davenpor, 'ProjectData/HCP'])
    imgsave(typeMASK, [type{1}, '_mask'], [davenpor, 'ProjectData/HCP'])
end

%%
typemask = spm_read_vols(spm_vol([davenpor, 'ProjectData/HCP/EMOTION_mask.nii']));

% for type = {'EMOTION', 'MOTOR', 'WM', 'GAMBLING'}
for type = {'WM'}
    typemask2 = spm_read_vols(spm_vol([davenpor, 'ProjectData/HCP', type{1}, '_mask.nii']));
    isequal(typemask, typemask2)
end

% They're all the same!

imgsave(typemask, 'HCPmask', [davenpor, 'ProjectData/HCP'])