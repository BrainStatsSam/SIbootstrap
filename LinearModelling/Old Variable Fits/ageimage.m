%Calculate the image of R^2 values when regressing against age and an
%intercept.
data = csvread('/vols/Scratch/ukbiobank/nichols/SelectiveInf/subject_vars_delim.csv');

ID_list = data(:,1);
all_ages = data(:,2);

dictionary = containers.Map(ID_list,all_ages);

my_list_of_subjects = csvread(jgit('DataSaving/Biobank Info/subjlist.txt'));

subs4mean = loaddata('subs4mean');
nsubj = length(subs4mean);

%% Age Vector and information

Age = zeros(1,nsubj);

for I = 1:nsubj
    subject_number = subs4mean(I);
    subject_ID = my_list_of_subjects(subject_number);
    
    Age(I) = dictionary(subject_ID);
end

nvar = (nsubj-1)*var(Age);

%% Load coefficients
alphahat = imgload('agelm_intercept');
betahat  = imgload('agelm_agecoeff');

%% Generate sigma^2 image

sigma2 = imgload('agelm_sigma2');

%% Generate t-image
global CSI
XtX = [nsubj, sum(Age); sum(Age), sum(Age.^2)];
XtXinv = inv(XtX);
t = betahat./sqrt(sigma2*XtXinv(2,2));
MNImask = imgload('MNImask');
t = t.*MNImask;

imgsave(t, 'r_agelm_t', CSI)

