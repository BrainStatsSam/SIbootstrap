%% This is unnecessary! As we've already done it!! Ie check the data file.

%Can use number 9: 
% 9.000,1.000,1.319,1.874,1.573,261468.000,1.498,1.264,251547.000

truth = imgload('fullmos');
MNImask = imgload('MNImask');
Sig = truth(:)';
smooth_var = 0;
top = 1;
nSubj = 50;
global stdsize
nVox = prod(stdsize);

startat = 151;

data = zeros([nSubj, nVox]);
subject_mask = ones(stdsize);
for I = 1:nSubj
    subj_number = I+startat-1;
    img = readimg(subj_number);
    subject_mask = subject_mask.*readimg(subj_number, 'mask');
    data(I,:) = img(:);
end

subject_mask = subject_mask.*MNImask;

[ est , estwas, trueval, ~ ] = tbias(1, top, 50, data, Sig, smooth_var, subject_mask);
fprintf('Boot: %f, Naive: %f, True: %f', est, estwas, trueval)

[ est, trueval, ~ ] = tindepsplit( data, 1, Sig, smooth_var, subject_mask);
fprintf('DataSplit: %f, Truth: %f', est, trueval)

%For startat = 101, have:
% Boot:  1.856096, Naive: 2.247327, True: 1.311761.
% DataSplit: 2.312201, Truth: 1.311761

