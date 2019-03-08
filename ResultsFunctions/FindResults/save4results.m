run = str2num(getenv('SGE_TASK_ID'));

if run == 1
    for Jmax = 1:247
        calcests_thresh('t4lm', 20, Jmax)
    end
elseif run == 2
    for Jmax = 1:98
        calcests_thresh('t4lm', 50, Jmax)
    end
elseif run == 3
    for Jmax = 1:47
        calcests_thresh('t4lm', 100, Jmax)
    end
end



