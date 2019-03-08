% This script generated the random list of subjects. Ie dividing the data
% randomly into those to be used for the mean and those not to be used for
% it.

rng(12345)
subselect = randsample(8945,4000,0);
subs4mean = sort(subids(subselect));
othersubs = setdiff(1:8945, subs4mean);



