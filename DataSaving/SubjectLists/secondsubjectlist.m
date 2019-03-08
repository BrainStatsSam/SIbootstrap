%Generate a Second Random list of subejcts to see whether indepsplit is
%still biased.

data_temp = load(jgit('DataSaving/gen_mean_t_mos/randsubjectlist.mat'));
subs4mean = data_temp.subs4mean;
othersubs = data_temp.othersubs;

rng(123)
othersubs2 = othersubs(randperm(length(othersubs)));

save(jgit('DataSaving/gen_mean_t_mos/randsubjectlist.mat'), 'subs4mean', 'othersubs', 'othersubs2')