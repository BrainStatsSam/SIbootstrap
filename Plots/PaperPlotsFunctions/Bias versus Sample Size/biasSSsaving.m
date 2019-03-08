group_sizes = 5:5:100;
type = 'tstat';
biasvsSS( type, group_sizes )

group_sizes = 5:5:100;
type = 'smoothtstat';
biasvsSS( type, group_sizes )

% group_sizes = 5:5:100;
% biasvsSS( 'mean' ,  group_sizes)
% biasvsSS( 'tstat' ,  group_sizes)
% biasvsSS( 'smoothtstat' ,  group_sizes)