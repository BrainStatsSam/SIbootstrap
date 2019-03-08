function var = bbvars( variable, random4000 )
% BBVARS( subj_number, variable ) returns the sex/age data. If 
%--------------------------------------------------------------------------
% ARGUMENTS
% variable      Specifies which variable is required. Eg: 'Age'.
% random4000    0/1. If 1 chooses returns the variables corresponding to
%               the random 4000 set aside for the mean. 0 returns the data 
%               corresponding to the other subjects.
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% %To be run on jala!
% Age = bbvars('Age');
% Sex = bbvars('Sex');
%--------------------------------------------------------------------------
% SEE ALSO
% 
if nargin < 2 
    random4000 = 1; %Ie the subjects set aside for the mean.
end

if strcmp(variable, 'Age') || strcmp(variable, 'age')
    var_number = 2;
elseif  strcmp(variable, 'Sex') || strcmp(variable, 'sex')
    var_number = 3;
else
    error('This variable is not found.')
end

var_data = csvread('/vols/Scratch/ukbiobank/nichols/SelectiveInf/subject_vars_delim.csv');

ID_list = var_data(:,1);
all_vars = var_data(:,var_number);

dictionaryVar = containers.Map(ID_list,all_vars);

my_list_of_subjects = csvread(jgit('DataSaving/SubjectLists/subjlist.txt'));

if random4000 == 1
    which_subjects = loaddata('subs4mean');
else
    which_subjects = loaddata('othersubs');
end

nsubj = length(which_subjects);

var = zeros(1,nsubj);

for I = 1:nsubj
    subject_number = which_subjects(I);
    subject_ID = my_list_of_subjects(subject_number);
    var(I) = dictionaryVar(subject_ID);
end

end

