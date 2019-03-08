global stdsize
global CSI
nVox = prod(stdsize);
MNImask = imgload('MNImask');
Sexvar = bbvars( 'Sex', 0 );

%%
nsubj = 20;
subjects = 1:nsubj;
subject_mask = ones(stdsize);
data = zeros([nsubj, nVox]);
for I = subjects
    img = readimg(I);
    subject_mask = subject_mask.*readimg(I, 'mask');
    data(I,:) = img(:);
end
xvar = Sexvar(subjects);

subject_mask = subject_mask.*MNImask;

[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar', data );
est_R2 = reshape(est_R2, stdsize);

est_R2 = est_R2.*zero2nan(subject_mask);

imgsave( est_R2, strcat('sexR2first',num2str(nsubj),'subjects'), CSI )


%%
nsubj = 50;

data = zeros([nsubj, nVox]);
subjects = 21:(20+nsubj);
subject_mask = ones(stdsize);
for I = subjects
    img = readimg(I);
    subject_mask = subject_mask.*readimg(I, 'mask');
    data((I-20),:) = img(:);
end
xvar = Sexvar(subjects);

subject_mask = subject_mask.*MNImask;

[ ~, ~, ~, ~, est_R2 ] = MVlm( xvar', data );
est_R2 = reshape(est_R2, stdsize);


est_R2 = est_R2.*zero2nan(subject_mask);

imgsave( est_R2, strcat('sexR2first',num2str(nsubj),'subjects'), CSI )
