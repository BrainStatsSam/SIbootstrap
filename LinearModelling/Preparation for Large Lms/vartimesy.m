%Without masking

data = csvread('/vols/Scratch/ukbiobank/nichols/SelectiveInf/subject_vars_delim.csv');

ID_list = data(:,1);
all_ages = data(:,2);
all_sexes = data(:,3);

dictionaryAge = containers.Map(ID_list,all_ages);
dictionarySex = containers.Map(ID_list,all_sexes);

my_list_of_subjects = csvread(jgit('DataSaving/Biobank Info/subjlist.txt'));

subs4mean = loaddata('subs4mean');
nsubj = length(subs4mean);

%% Age, Sex Vector and information

Age = zeros(1,nsubj);
Sex = zeros(1,nsubj);

for I = 1:nsubj
    subject_number = subs4mean(I);
    subject_ID = my_list_of_subjects(subject_number);
    
    Age(I) = dictionaryAge(subject_ID);
    Sex(I) = dictionarySex(subject_ID);
end

%% 
global stdsize
agey = zeros(stdsize);
sexy = zeros(stdsize);
agesexy = zeros(stdsize);

for I = 1:nsubj
    subject_image = readimg(subs4mean(I),'copes', 1);
    
    agey = agey + subject_image*Age(I);
    sexy = sexy + subject_image*Sex(I);
    agesexy = agesexy + subject_image*Sex(I)*Age(I);
    disp(I);
end

imgsave(agey,'r_agey',CSI)
imgsave(sexy,'r_sexy',CSI)
imgsave(agesexy,'r_agesexy',CSI)
