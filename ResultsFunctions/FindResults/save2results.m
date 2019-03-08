run = str2num(getenv('SGE_TASK_ID'));

if run == 1
    for Jmax = 1:32
        calcests_thresh('vbmagesex', 150, Jmax, 100, 'vbm_mask001')
    end
elseif run == 2
    for Jmax = 1:24
        calcests_thresh('vbmagesex', 200, Jmax, 100, 'vbm_mask001')
    end
elseif isempty(run) || run == 3
    for Jmax = 1:16
        calcests_thresh('vbmagesex', 300, Jmax, 100, 'vbm_mask001')
    end
end


% if run == 1
%     for Jmax = 1:32
%         calcests_thresh('vbmagesex', 150, Jmax)
%     end
% elseif run == 2
%     for Jmax = 1:32
%         calcests_thresh('vbmagesex', 150, Jmax, 100, 'vbm_mask001')
%     end
% elseif run == 3
%     for Jmax = 1:24
%         calcests_thresh('vbmagesex', 200, Jmax)
%     end
% elseif run == 4
%     for Jmax = 1:24
%         calcests_thresh('vbmagesex', 200, Jmax, 100, 'vbm_mask001')
%     end
% elseif run == 5
%     for Jmax = 1:16
%         calcests_thresh('vbmagesex', 300, Jmax)
%     end
% elseif isempty(run) || run == 6
%     for Jmax = 1:16
%         calcests_thresh('vbmagesex', 300, Jmax, 100, 'vbm_mask001')
%     end
% end

