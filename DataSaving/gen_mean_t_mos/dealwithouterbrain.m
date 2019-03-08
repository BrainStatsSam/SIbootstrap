fullmean = imgload('fullmean');
fullmos = imgload('fullmos');
MNImask = logical(imgload('MNImask'));

global stdsize
fullmeanNAN = zeros(stdsize);
fullmeanNAN(MNImask) = fullmean(MNImask);

fullmosNAN = zeros(stdsize);
fullmosNAN(MNImask) = fullmos(MNImask);

imgsave(fullmeanNAN,'fullmeanzeroed',2)
imgsave(fullmosNAN,'fullmoszeroed',2)

%%
fullmean = imgload('fullmean');
fullmos = imgload('fullmos');
MNImask = logical(imgload('MNImask'));

fullmeanNAN = nan(stdsize);
fullmeanNAN(MNImask) = fullmean(MNImask);

fullmosNAN = nan(stdsize);
fullmosNAN(MNImask) = fullmos(MNImask);

imgsave(fullmeanNAN,'fullmeanNAN',2)
imgsave(fullmosNAN,'fullmosNAN',2)
