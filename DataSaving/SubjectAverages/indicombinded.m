% global stdsize
% mean_img = zeros(stdsize);
% 
% nsubj = 50;
% data = zeros(nsubj, prod(stdsize));
% MNI_brain = imgload('MNImaskNAN');
% for I = 1:nsubj
%     I
%     img = readimg(I);
%     mask = readimg(I,'mask',1);
%     img = img.*mask.*MNI_brain;
%     data(I,:) = img(:);
% end
% 
% [ xbar, ~, mos ] = meanmos( data, 0, 1);
% 
% imgsave( xbar, 'first50mean', CSI )
% imgsave( mos, 'first50mos', CSI )
%%
% global stdsize
% 
% nsubj = 50;
% startat = 101;
% data = zeros(nsubj, prod(stdsize));
% MNI_brain = imgload('MNImaskNAN');
% for I = 1:nsubj
%     I
%     subj_number = I+startat-1;
%     img = readimg(subj_number);
%     mask = readimg(subj_number,'mask',1);
%     img = img.*mask.*MNI_brain;
%     data(I,:) = img(:);
% end
% 
% [ xbar, ~, mos ] = meanmos( data, 0, 1);
% 
% imgsave( xbar, '3rd50mean', CSI )
% imgsave( mos, '3rd50mos', CSI )
% 
% %%
% nsubj = 50;
% nsubjover2 = nsubj/2;
% startat = 101;
% data1 = zeros(nsubjover2, prod(stdsize));
% data2 = zeros(nsubjover2, prod(stdsize));
% MNI_brain = imgload('MNImaskNAN');
% for I = 1:nsubjover2
%     I
%     subj_number = I+startat-1;
%     img = readimg(subj_number);
%     mask = readimg(subj_number,'mask');
%     img = img.*mask.*MNI_brain;
%     data1(I,:) = img(:);
% end
% for I = 1:nsubjover2
%     I
%     subj_number = I + nsubjover2 + startat-1;
%     img = readimg(subj_number);
%     mask = readimg(subj_number,'mask');
%     img = img.*mask.*MNI_brain;
%     data2(I,:) = img(:);
% end
% 
% [ xbar1, ~, mos1 ] = meanmos( data1, 0, 1);
% [ xbar2, ~, mos2 ] = meanmos( data2, 0, 1);
% 
% imgsave( xbar1, '3rdfirst25mean', CSI )
% imgsave( mos1, '3rdfirst25mos', CSI )
% imgsave( xbar2, '3rdsecond25mean', CSI )
% imgsave( mos2, '3rdsecond25mos', CSI )



%%
nsubj = 50;
startat = 401;
data = zeros(nsubj, prod(stdsize));
MNImask = imgload('MNImaskNAN');
for I = 1:nsubj
    I
    subj_number = I+startat-1;
    img = readimg(subj_number);
    mask = readimg(subj_number,'mask',1);
    img = img.*mask.*MNImask;
    data(I,:) = img(:);
end

[ xbar, ~, mos ] = meanmos( data, 0, 1, 0);

imgsave( xbar, '9th50meannan', CSI )
imgsave( mos, '9th50mosnan', CSI )

%%
% global stdsize

nsubj = 50;
nsubjover2 = nsubj/2;
startat = 401;
data1 = zeros(nsubjover2, prod(stdsize));
data2 = zeros(nsubjover2, prod(stdsize));
MNImask = imgload('MNImaskNAN');
for I = 1:nsubjover2
    I
    subj_number = I+startat-1;
    img = readimg(subj_number);
    mask = readimg(subj_number,'mask');
    img = img.*mask.*MNImask;
    data1(I,:) = img(:);
end
for I = 1:nsubjover2
    I
    subj_number = I + nsubjover2 + startat-1;
    img = readimg(subj_number);
    mask = readimg(subj_number,'mask');
    img = img.*mask.*MNImask;
    data2(I,:) = img(:);
end

[ xbar1, ~, mos1 ] = meanmos( data1, 0, 1, 0);
[ xbar2, ~, mos2 ] = meanmos( data2, 0, 1, 0);

imgsave( xbar1, '9thfirst25meannan', CSI )
imgsave( mos1, '9thfirst25mosnan', CSI )
imgsave( xbar2, '9thsecond25meannan', CSI )
imgsave( mos2, '9thsecond25mosnan', CSI )

%%
nsubj = 50;
startat = 401;
data = zeros(nsubj, prod(stdsize));
MNImask = imgload('MNImaskNAN');
for I = 1:nsubj
    I
    subj_number = I+startat-1;
    img = readimg(subj_number);
    mask = readimg(subj_number,'mask',1);
    img = img.*mask.*MNImask;
    data(I,:) = img(:);
end

[ xbar, ~, mos ] = meanmos( data, 0, 1, 0);

imgsave( xbar, '9th50meannan', CSI )
imgsave( mos, '9th50mosnan', CSI )

%%
% global stdsize

nsubj = 50;
nsubjover2 = nsubj/2;
startat = 651;
data1 = zeros(nsubjover2, prod(stdsize));
data2 = zeros(nsubjover2, prod(stdsize));
MNImask = imgload('MNImask');
subject_mask = MNImask;
for I = 1:nsubj
    subj_number = I+startat-1;
    subject_mask = subject_mask.*readimg(subj_number,'mask');
end

for I = 1:nsubjover2
    I
    subj_number = I+startat-1;
    img = readimg(subj_number);
    img = img.*subject_mask;
    data1(I,:) = img(:);
end
for I = 1:nsubjover2
    I
    subj_number = I + nsubjover2 + startat-1;
    img = readimg(subj_number);
    img = img.*subject_mask;
    data2(I,:) = img(:);
end

[ xbar1, ~, mos1 ] = meanmos( data1, 0, 1, 0);
[ xbar2, ~, mos2 ] = meanmos( data2, 0, 1, 0);

imgsave( xbar1, '14thfirst25mean', CSI )
imgsave( mos1, '14thfirst25mos', CSI )
imgsave( xbar2, '14thsecond25mean', CSI )
imgsave( mos2, '14thsecond25mos', CSI )

%%
data = [data1; data2];

[ xbar, ~, mos ] = meanmos( data, 0, 1, 0);

imgsave( xbar, '14th50mean', CSI )
imgsave( mos, '14th50mos', CSI )

%%
nsubj = 50;
nsubjover2 = nsubj/2;
startat = 1001;
data1 = zeros(nsubjover2, prod(stdsize));
data2 = zeros(nsubjover2, prod(stdsize));
MNImask = imgload('MNImaskNAN');
% subject_mask = MNImask;
% for I = 1:nsubj
%     subj_number = I+startat-1;
%     subject_mask = subject_mask.*readimg(subj_number,'mask');
% end

for I = 1:nsubjover2
    I
    subj_number = I+startat-1;
    img = readimg(subj_number);
    data1(I,:) = img(:);
end
for I = 1:nsubjover2
    I
    subj_number = I + nsubjover2 + startat-1;
    img = readimg(subj_number);
    data2(I,:) = img(:);
end

[ xbar1, ~, mos1 ] = meanmos( data1, 0, 1, 0);
[ xbar2, ~, mos2 ] = meanmos( data2, 0, 1, 0);

imgsave( xbar1, '21stfirst25mean', CSI )
imgsave( mos1, '21stfirst25mos', CSI )
imgsave( xbar2, '21stsecond25mean', CSI )
imgsave( mos2, '21stsecond25mos', CSI )

%%
data = [data1; data2];

[ xbar, ~, mos ] = meanmos( data, 0, 1, 0);

imgsave( xbar, '21st50mean', CSI )
imgsave( mos, '21st50mos', CSI )