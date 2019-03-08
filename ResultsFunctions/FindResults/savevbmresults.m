run = str2num(getenv('SGE_TASK_ID'));

if run == 1
    for Jmax = 1:247
        calcests_thresh('tstat', 20, Jmax)
    end
elseif run == 2
    for Jmax = 1:98
        calcests_thresh('tstat', 50, Jmax)
    end
elseif run == 3
    for Jmax = 1:47
        calcests_thresh('tstat', 100, Jmax)
    end
end



for Jmax = 1:32
    calcests_thresh('vbmagesex', 150, Jmax)
end

for Jmax = 1:47
    calcests_thresh('vbmagesex', 100, Jmax)
end

for Jmax = 1:98
    calcests_thresh('vbmagesex', 50, Jmax)
end

