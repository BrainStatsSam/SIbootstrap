firsthalf = imgload('9thfirst25mos');
secondhalf = imgload('9thsecond25mos');
truth = imgload('fullmos');

max(firsthalf(:))
max_loc = lmindices(firsthalf,1)
firsthalf(max_loc)
secondhalf(max_loc)
truth(max_loc)

convind(max_loc)
%%

naive = imgload('9th50mos');
max(naive(:))
locnaive = lmindices(naive, 1)
convind(locnaive)
truth(locnaive)

%%
truth_max = lmindices(truth,1)
truth(truth_max)
convind(truth_max)

%% surfs
% naive(naive < 0 ) = 0;
set(0,'defaultAxesFontSize', 20);
surfnaive = reshape(naive(:,40,:), [91,91])';
surf(surfnaive)
xlabel('x')
ylabel('z')
xlim([12,80])
ylim([1,77])
zlim([-0.3,1.6])
zlabel('Cohen''s d')
set(gcf, 'position', [500,500,1400,600])
h= title('50 subject estimate')
set ( h, 'position', [63,63,1.3] )
export_fig(jgit('Plots/OHBMplots/naivesurf.pdf'), '-transparent')

%%
surftruth = nan2zero(reshape(truth(:,41,:), [91,91]))';
surf(surftruth)
xlabel('x')
ylabel('z')
xlim([12,80])
ylim([1,77])
zlim([-0.3,1.6])
zlabel('Cohen''s d')
set(gcf, 'position', [500,500,1400,600])
h=title('True Cohen''s d')
set ( h, 'position', [63,63,1.3] )
export_fig(jgit('Plots/OHBMplots/truthsurf.pdf'), '-transparent')

%%

firsthalf = imgload('14thfirst25mos');
secondhalf = imgload('14thsecond25mos');
truth = imgload('fullmos');
subject_mask = imgload('14thsubjmask');

max(firsthalf(:))
max_loc = lmindices(firsthalf,1, subject_mask)
firsthalf(max_loc)
secondhalf(max_loc)
truth(max_loc)

convind(max_loc)
%%

naive = imgload('14th50mos');
max(naive(:))
locnaive = lmindices(naive, 1, subject_mask)
convind(locnaive)

%%
truth_max = lmindices(truth,1, MNImask)
truth(truth_max)
convind(truth_max)

%%
set(0,'defaultAxesFontSize', 20);
surfnaive = nan2zero(reshape(naive(:,37,:), [91,91]))';
surf(surfnaive)
xlabel('x')
ylabel('z')
xlim([12,80])
ylim([1,77])
zlim([-0.3,1.6])
zlabel('Cohen''s d')
set(gcf, 'position', [500,500,1400,600])
h= title('50 subject estimate')
set ( h, 'position', [63,63,1.3] )
export_fig(jgit('Plots/OHBMplots/naivesurf14.pdf'), '-transparent')

%%
surftruth = nan2zero(reshape(truth(:,37,:), [91,91]))';
surf(surftruth)
xlabel('x')
ylabel('z')
xlim([12,80])
ylim([1,77])
zlim([-0.3,1.6])
zlabel('Cohen''s d')
set(gcf, 'position', [500,500,1400,600])
h=title('True Cohen''s d')
set ( h, 'position', [63,63,1.3] )
export_fig(jgit('Plots/OHBMplots/truthsurf14.pdf'), '-transparent')

%%

firsthalf = imgload('21stfirst25mos');
secondhalf = imgload('21stsecond25mos');
MNImask = imgload('MNImask');
% MNImask = imgload('MNImaskNAN')
% imgsave(firsthalf.*MNImask, '21stfirst25mosnan', 2);
% imgsave(secondhalf.*MNImask, '21stsecond25mosnan', 2);

truth = imgload('fullmos');
subject_mask = imgload('21stsubjectmask');

max(firsthalf(:))
max_loc = lmindices(firsthalf,1, subject_mask)
firsthalf(max_loc)
secondhalf(max_loc)
truth(max_loc)

convind(max_loc)
%%
naive = imgload('21st50mos');
naive_masked = naive.*subject_mask;
max(naive(:))
locnaive = lmindices(naive, 1, subject_mask)
convind(locnaive)

%%
truth_max = lmindices(truth,1, MNImask)
truth(truth_max)
convind(truth_max)

%%
set(0,'defaultAxesFontSize', 20);
surfnaive = nan2zero(reshape(naive_masked(:,42,:), [91,91]))';
surf(surfnaive)
xlabel('x')
ylabel('z')
xlim([12,80])
ylim([1,77])
zlim([-0.3,1.6])
zlabel('Cohen''s d')
set(gcf, 'position', [500,500,1400,600])
h= title('50 subject estimate')
set ( h, 'position', [63,63,1.3] )
export_fig(jgit('Plots/OHBMplots/naivesurf21.pdf'), '-transparent')

%%
surftruth = nan2zero(reshape(truth(:,41,:), [91,91]))';
surf(surftruth)
xlabel('x')
ylabel('z')
xlim([12,80])
ylim([1,77])
zlim([-0.3,1.6])
zlabel('Cohen''s d')
set(gcf, 'position', [500,500,1400,600])
h=title('True Cohen''s d')
set ( h, 'position', [63,63,1.3] )
export_fig(jgit('Plots/OHBMplots/truthsurf21.pdf'), '-transparent')

