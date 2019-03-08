% Write up code that runs this for 10, 20, 25, 50, 100 and saves the
% results! Remember to subtract the mean calculated using the 4000.

run = str2num(getenv('SGE_TASK_ID'));
current_run = 0;
number_of_runs = 5;

niters = 5000;
agecoeff = imgload('smooth_vbm_agelm_agecoeff');
vbm_mask01 = imgload('vbm_mask01');
vbm_mask001 = imgload('vbm_mask001');
Agevar = bbvars( 'Age', 0 );
global stdsize
nvox = prod(stdsize);

% for groupsize = [25,50,75,100,150]
groupsizes = [150, 100, 75, 50, 25];
while current_run < number_of_runs
    current_run = current_run + 1;
    if run == current_run
        groupsize = groupsizes(current_run);
        if exist(jgit(['AnalyzeData/Thresholds/vbmagesex_001_max_dist_', num2str(groupsize)]), 'file') == 2
            iter_start = sum(max_dist_001 ~= 0) + 1;
        else
            iter_start = 1;
        end
        for iter = iter_start:niters
            iter
            if iter > 1
                tmp = load(jgit(['AnalyzeData/Thresholds/vbmagesex_001_max_dist_', num2str(groupsize)]));
                max_dist_001 = tmp.max_dist_001;
                tmp = load(jgit(['AnalyzeData/Thresholds/vbmagesex_01_max_dist_', num2str(groupsize)]), 'max_dist_01');
                max_dist_01 = tmp.max_dist_01;
            else
                max_dist_001 = zeros(1, niters);
                max_dist_01 = zeros(1, niters);
            end
            
            random_sample = randsample(4945, groupsize);
            xvar = Agevar(random_sample)';
            data = zeros(groupsize, nvox);
            for I = 1:groupsize
                img = readvbm(random_sample(I));
                data(I, :) = img(:) - xvar(I)*agecoeff(:);
            end
            
            [ ~, ~, ~, ~, ~, tstat ] = MVlm( xvar, data );
            Fstat = tstat.^2;
            
            max_tstat_index_001 = lmindices(Fstat, 1, vbm_mask001);
            max_tstat_index_01 = lmindices(Fstat, 1, vbm_mask01);
            
            max_dist_001(iter) = Fstat(max_tstat_index_001);
            max_dist_01(iter) = Fstat(max_tstat_index_01);
            save(jgit(['AnalyzeData/Thresholds/vbm001_max_dist_', num2str(groupsize)]), 'max_dist_001')
            save(jgit(['AnalyzeData/Thresholds/vbm01_max_dist_', num2str(groupsize)]), 'max_dist_01')
        end
    end
end

