run = str2num(getenv('SGE_TASK_ID'));

if run == 1
    for Jmax = 1:32
        calcests_thresh('vbmage', 150, Jmax)
    end
elseif run == 2
    for Jmax = 1:32
        calcests_thresh('vbmage', 150, Jmax, 100, 'vbm_mask001')
    end
elseif run == 3
    for Jmax = 1:47
        calcests_thresh('vbmage', 100, Jmax)
    end
elseif run == 4
    for Jmax = 1:47
        calcests_thresh('vbmage', 100, Jmax, 100, 'vbm_mask001')
    end
elseif run == 5
    for Jmax = 1:98
        calcests_thresh('vbmage', 50, Jmax)
    end
elseif isempty(run) || run == 6
    for Jmax = 1:98
        calcests_thresh('vbmage', 50, Jmax, 100, 'vbm_mask001')
    end
end




