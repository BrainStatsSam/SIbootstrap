% thresh = 1;
% no_axis_limits = 1;
% for type = {'mean'}
%     for groupsize = [20,50,100]
%         type{1}
%         groupsize
%         plotXbars(type{1}, groupsize, thresh, no_axis_limits)
%     end
% end
%See Below for the mean! ie plot_indi_plots.m 

%%

thresh = 1;
no_axis_limits = 1;
for type = {'mean', 'tstat', 't4lm'}
    for groupsize = [20,50,100]
        type{1}
        groupsize
        plotXbars(type{1}, groupsize, thresh, no_axis_limits)
        pause
    end
end

%%
thresh = 1;
no_axis_limits = 0;
for type = {'vbmagesexR2'}
    for groupsize = 300
        type{1}
        groupsize
        plotXbars(type{1}, groupsize, '001', thresh, no_axis_limits)
    end
end

%%

thresh = 1;
no_axis_limits = 0;
for type = {'vbmagesexf2'}
    for groupsize = 300
        type{1}
        groupsize
        plotXbars(type{1}, groupsize, '001', thresh, no_axis_limits)
    end
end

%%
thresh = 1;
no_axis_limits = 0;
for type = {'vbmagesexfish'}
    for groupsize = 150
        type{1}
        groupsize
        plotXbars(type{1}, groupsize, '001', thresh, no_axis_limits)
    end
end

%%
thresh = 1;
no_axis_limits = 0;
for type = {'vbmagesext'}
    for groupsize = 200
        type{1}
        groupsize
        plotXbars(type{1}, groupsize, '001', thresh, no_axis_limits)
    end
end

%%
thresh = 1;
no_axis_limits = 0;
for type = {'mean'}
    for groupsize = [20,50,100]
        for use_trans = [0,1]
            type{1}
            groupsize
            plot_indi_plots( type{1}, groupsize, use_trans, thresh, no_axis_limits );
        end
    end
end

%%
thresh = 1;
no_axis_limits = 0;
for type = {'mean', 'tstat', 't4lm'}
    for groupsize = [20,50,100]
        for use_trans = [0,1]
            type{1}
            groupsize
            plot_indi_plots( type{1}, groupsize, use_trans, thresh, no_axis_limits );
        end
    end
end

%%
thresh = 1;
no_axis_limits = 0;
for type = {'tstat', 't4lm', 'mean'}
    for groupsize = [20,50,100]
        type{1}
        plot_indi_plots( type{1}, groupsize, 1, thresh, no_axis_limits );
    end
end

%%
thresh = 1;
no_axis_limits = 0;
for type = {'tstat'}
    for groupsize = [20,50,100]
        type{1}
        plot_indi_plots( type{1}, groupsize, 1, thresh, no_axis_limits );
    end
end

%%
thresh = 1;
for type = {'vbmagesexR2'}
    for groupsize = [50,100,150]
        plot_indi_plots( type{1}, groupsize, 1, thresh, 0, '001');
    end
end

%%
for type = {'vbmagesext'}
    for groupsize = [50, 100, 200]
            plot_indi_plots( type{1}, groupsize, 1, thresh, 0, '001');
    end
end

%%
use_trans = 1;
no_axis_limits = 1;
type = 'tstat';
for groupsize = [20,50,100]
    plotEstsvsNaive( type, groupsize, use_trans, thresh, no_axis_limits ) 
end

use_trans = 1;
no_axis_limits = 0;
type = 't4lm';
for groupsize = [20,50,100]
    plotEstsvsNaive( type, groupsize, use_trans, thresh, no_axis_limits ) 
end