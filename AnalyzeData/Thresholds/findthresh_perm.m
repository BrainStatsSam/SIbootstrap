run = str2num(getenv('SGE_TASK_ID'));
current_run = 0;
number_of_runs = 5;

niters = 10;
max_iters = 5000;
for groupsize = [25,50,75,100,150]
    if exist(jgit(['AnalyzeData/Thresholds/max_dist_PERM',num2str(groupsize),'.mat']), 'file') == 0
        max_dist = zeros(1, (niters+1)*max_iters/niters);
        groupsize
        for iter = 1:max_iters/niters
            iter
            random_sample = randsample(4945, groupsize);
            data = getdata( random_sample );
            subject_mask = loadsubs( random_sample, 'give_mask', 0, '3D');
            max_dist(
            [~, vecofmaxima] = perm_thresh( data, 'T', niters, subject_mask)
            max_dist((iter-1)*niters+1) = 
            max_dist((iter-1)*niters+2:iter*(niters+1)) = vecofmaxima;
        end
        save(jgit(['AnalyzeData/Thresholds/max_dist_', num2str(groupsize)]), 'max_dist')
    end
end