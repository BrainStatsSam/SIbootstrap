data = csvread('/vols/Scratch/ukbiobank/nichols/SelectiveInf/subject_vars_delim.csv');

ID_list = data(:,1);
all_sexes = data(:,3);

dictionary = containers.Map(ID_list,all_sexes);

my_list_of_subjects = csvread(jgit('DataSaving/Biobank Info/subjlist.txt'));

subs4mean = loaddata('subs4mean');
nsubj = length(subs4mean);

%% Age, Sex Vector and information

Sex = zeros(1,nsubj);

for I = 1:nsubj
    subject_number = subs4mean(I);
    subject_ID = my_list_of_subjects(subject_number);
    
    Sex(I) = dictionary(subject_ID);
end

nvar = (nsubj-1)*var(Sex);

%%
global stdsize

average_sex = mean(Sex);

betahat = zeros(stdsize);
image_mean = imgload('mean');
for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    betahat = betahat + (subject_image - image_mean)*(Sex(I) - average_sex);
    disp(I);
end

betahat = betahat/nvar;

alphahat = image_mean - betahat*average_sex;

%% Saving 

%r signifies the fact that they have each been calculated using the 4000
%subjects set aside for calculating the mean and other things.
imgsave(betahat, 'r_sexlm_sexcoeff', CSI)
imgsave(alphahat, 'r_sexlm_intercept', CSI)

%% Generate sigma^2 image

sigma2 = 0;
for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    sigma2 = sigma2 + (subject_image - alphahat - betahat*Sex(I)).^2;
end

sigma2 = sigma2/(nsubj-1);

imgsave(sigma2, 'r_sexlm_sigma2', CSI)


%% Generate t-image
t = sqrt(nsubj)*betahat./sigma2;
MNImask = imgload('MNImask');
t = t.*MNImask;

imgsave(t, 'r_sexlm_t', CSI)

%% Generate R2 image

num_R2 = zeros(stdsize);
denom_R2 = zeros(stdsize);
img_mean = imgload('mean');

for I = 1:nsubj
    fitted_values_img = alphahat + betahat*Sex(I);
    
    %numerator
    num_R2 = num_R2 + (fitted_values_img - img_mean).^2;
    
    %denominator
    subject_image = readimg(subs4mean(I),'copes', 1);
    denom_R2 = denom_R2 + (subject_image - img_mean).^2;
    disp(I);
end

R2 = num_R2./denom_R2;

imgsave(R2, 'r_sexlm_R2', CSI)