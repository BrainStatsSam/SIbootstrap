% Write up code that runs this for 10, 20, 25, 50, 100 and saves the
% results! Remember to subtract the mean calculated using the 4000.
run = str2num(getenv('SGE_TASK_ID'));
current_run = 0;
number_of_runs = 3;

niters = 5000;
vbm_mask01 = imgload('vbm_mask01');
vbm_mask001 = imgload('vbm_mask001');
Agevar = bbvars( 'Age', 0 );
Sexvar = bbvars( 'Sex', 0);
contrast = [0,0,1];
global stdsize
nvox = prod(stdsize);

groupsizes = [75, 50, 25];
while current_run < number_of_runs
    current_run = current_run + 1;
    if run == current_run
        groupsize = groupsizes(current_run);
        if exist(jgit(['AnalyzeData/Thresholds/vbmagesex_001_max_dist_', num2str(groupsize)]), 'file') == 2
            iter_start = sum(max_dist_001(1,:) ~= 0) + 1;
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
                max_dist_001 = zeros(2, niters);
                max_dist_01 = zeros(2, niters);
            end
            
            random_sample = randsample(4945, groupsize);
            xvarage = Agevar(random_sample)';
            xvarsex = Sexvar(random_sample)';
            X = [xvarsex, xvarage];
            
            data = zeros(groupsize, nvox);
            for I = 1:groupsize
                img = readvbm(I);
                data(I, :) = img(:);
            end
            
            out = MVlm_multivar(  X, data, contrast, 1 );
            for I = 1:groupsize
                data(I, :) = data(I, :) - xvarage(I)*out.coeffs(3, :);
            end
            
            out2 = MVlm_multivar(  X, data, contrast, 1 );
            
            max_tstat_index_001 = lmindices(out2.tstat, 1, vbm_mask001);
            max_tstat_index_01 = lmindices(out2.tstat, 1, vbm_mask01);
            max_Fstat_index_001 = lmindices(out2.Fstat, 1, vbm_mask001);
            max_Fstat_index_01 = lmindices(out2.Fstat, 1, vbm_mask01);
            
            max_dist_001(1,iter) = out2.tstat(max_tstat_index_001);
            max_dist_01(1,iter) = out2.tstat(max_tstat_index_01);
            max_dist_001(2,iter) = out2.Fstat(max_Fstat_index_001);
            max_dist_01(2,iter) = out2.Fstat(max_Fstat_index_01);
            save(jgit(['AnalyzeData/Thresholds/vbmagesex_001_max_dist_', num2str(groupsize)]), 'max_dist_001')
            save(jgit(['AnalyzeData/Thresholds/vbmagesex_01_max_dist_', num2str(groupsize)]), 'max_dist_01')
        end
    end
end

% out = MVlm_multivar(  X, data, contrast, 1 );
% for I = 1:groupsize
%     data(I, :) = data(I, :) - xvarage(I)*out.coeffs(3, :);
% end
% 
% out2 = MVlm_multivar(  X, data, contrast, 1 );
% 
% max_tstat_index_001 = lmindices(out2.tstat, 1, vbm_mask001);
% max_tstat_index_01 = lmindices(out2.tstat, 1, vbm_mask01);
% max_Fstat_index_001 = lmindices(out2.Fstat, 1, vbm_mask001);
% max_Fstat_index_01 = lmindices(out2.Fstat, 1, vbm_mask01);
% 
% max_dist_001(1,iter) = out2.tstat(max_tstat_index_001);
% max_dist_01(1,iter) = out2.tstat(max_tstat_index_01);
% max_dist_001(2,iter) = out2.Fstat(max_Fstat_index_001);
% max_dist_01(2,iter) = out2.Fstat(max_Fstat_index_01);
% save(jgit(['AnalyzeData/Thresholds/vbmagesex_001_max_dist_', num2str(groupsize)]), 'max_dist_001')
% save(jgit(['AnalyzeData/Thresholds/vbmagesex_01_max_dist_', num2str(groupsize)]), 'max_dist_01')
