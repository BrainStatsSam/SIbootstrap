run = str2num(getenv('SGE_TASK_ID'));

if run == 1
    for Jmax = 1:98
        calcests_thresh('vbmagesex', 50, Jmax, 100, 'vbm_mask001')
    end
elseif isempty(run) || run == 2
    for Jmax = 1:47
        calcests_thresh('vbmagesex', 100, Jmax, 100, 'vbm_mask001')
    end
end