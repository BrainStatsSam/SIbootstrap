function [ out ] = circvsbootplots_gen( type, groupsize )
% NEWFUN serves as a function template.
%--------------------------------------------------------------------------
% ARGUMENTS
%
%--------------------------------------------------------------------------
% OUTPUT
%
%--------------------------------------------------------------------------
% EXAMPLES
%
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.

out.height = 800;
out.width = 800;
if strcmp(type, 't') || strcmp(type, 'tstat')
    type = 'tstat';
    axis_label = 'Cohen''s d';
    nct = 1;
elseif strcmp(type, 't4lm')
    type = 't4lm';
    axis_label = 'Mean';
    nct = 1;
elseif strcmp(type, 'mean')
    axis_label = 'Mean';
    nct = 0;
elseif strcmp(type, 'vbmagesex') && thresh == 1
    axis_label = 'R^2';
    nct = 0;
else
    error('type not found')
end

label_for_x = ['Circular ',axis_label];
label_for_y = ['Bootstrap Corrected ',axis_label];
if groupsize == 20
    if strcmp(type, 'mean')
        out.xlims_naive = [1.00,3.00];
        out.ylims_naive = [4.0,2.00];
    elseif strcmp(type, 'tstat')
        out.width = 1.4*out.width;
        out.xlims_naive = [1.3,3.5];
        out.ylims_naive = [0,1.6];
        out.trans_level = 0.4;
    end
elseif groupsize == 50
    if strcmp(type, 'mean')
        out.xlims = [.50,1.40];
        out.ylims = [.40,2.00];
        out.xlims_naive = [1.00,2.00];
        out.ylims_naive = [.70,1.90];
        out.trans_level = 0.4;
    elseif strcmp(type, 'tstat')
        out.xlims_naive = [0.75,2.5];
        out.ylims_naive = [0,1.6];
        out.trans_level = 0.4;
    elseif strcmp(type, 't4lm')
        out.xlims = [0,1.40];
        out.ylims = [-.10,1.80];
        out.xlims_naive = [-0.3,2.7];
        out.ylims_naive = [-0.7,2.7];
    elseif strcmp(type, 'vbmagesex')
        out.xlims = [0,0.25];
        out.ylims = [0,0.55];
        out.trans_level = 0.6;
    end
elseif groupsize == 100
    if strcmp(type, 'mean')
        out.xlims = [.70,1.40];
        out.ylims = [.60,1.70];
        out.xlims_naive = [1.00,1.80];
        out.ylims_naive = [.80,1.80];
        out.trans_level = 0.6;
    elseif strcmp(type, 'tstat')
        out.xlims_naive = [0.5,2.1];
        out.ylims_naive = [0,1.6];
        out.trans_level = 0.4;
    elseif strcmp(type, 't4lm')
        out.xlims = [0,1.40];
        out.ylims = [0,1.70];
        out.xlims_naive = [-0.3,2.7];
        out.ylims_naive = [-0.7,2.7];
    elseif strcmp(type, 'vbmagesex')
        out.xlims = [0,0.25];
        out.ylims = [0,0.45];
        out.trans_level = 0.4;
    end
elseif groupsize == 150
    if strcmp(type, 'vbmagesex')
        out.xlims = [0,0.25];
        out.ylims = [0,0.4];
        out.trans_level = 0.4;
    end
end
    

if strcmp(type, 't4lm')
    out.xlims_naive = [0,1.8];
    out.ylims_naive = [0,1.8];
end

% For the mean need to add stuff below!
% if strcmp(type, 'tstat')
%     out.xlims_naive = [0.7,3.5];
%     out.ylims_naive = [0,2];
% elseif strcmp(type, 't4lm')
%     out.xlims_naive = [0,2.00];
%     out.ylims_naive = [0,2.00];
% end

if strcmp(type, 'mean')
    if groupsize == 20
        out.xtick = -0.25:0.25:1.4;
    elseif groupsize == 50
        out.xtick =  0.6:0.2:1.4;
    elseif groupsize == 100
        out.xtick =  0.8:0.2:1.4;
    end
elseif strcmp(type, 't4lm')
    out.xtick = 0:0.2:1.4;
elseif strcmp(type, 'tstat')
    out.xtick = 1.5:0.5:3.5;
elseif strcmp(type, 'vbmagesex')
    out.xtick = 0:0.05:0.25;
end

% out.xlims_naive = 'mode';
% out.ylims_naive = 'mode';
% out.circ_size = [diff(out.xlims), diff(out.ylims)]/100;
out.circ_size_naive = [diff(out.xlims_naive), diff(out.ylims_naive)]/100;

%% Load Data
[A, B] = loadres_thresh(type, groupsize);

if strcmp(type, 'vbmagesex')
    out.boot = A(:,3);
    out.naive = A(:,5);
    out.is = B(:,3);
    out.truenaiveboot = A(:,9);
    out.trueatlocis = B(:,5);
    out.Amax = A(:,2);
    out.Bmax = B(:,2);
else
    if nct == 1
        out.boot = A(:,3)/nctcorrection(groupsize);
        out.naive = A(:,4)/nctcorrection(groupsize); %correcting for non-central t
        out.is = B(:,3)/nctcorrection(groupsize/2);
    else
        out.boot = A(:,3);
        out.naive = A(:,4);
        out.is = B(:,3);
    end
    out.truenaiveboot = A(:,5);
    out.trueatlocis = B(:,4);
    out.Amax = A(:,2);
    out.Bmax = B(:,2);
end

if strcmp(type, 'mean') || strcmp(type, 't4lm')
    out.boot = out.boot/100;
    out.is = out.is/100;
    out.naive = out.naive/100;
    
    out.truenaiveboot = out.truenaiveboot/100;
    out.trueatlocis = out.trueatlocis/100;
end

%% Save location
global SIbootstrap_loc
global def_col
groupsize_str = num2str(groupsize);
saveloc = [SIbootstrap_loc, 'Results_Figures/CircvsBootFigures/'];
filestart = [saveloc, 'circvsboot_nsubj', groupsize_str];

%% Generate Plot
axis_font_size = 25;

transplot(out.naive, out.boot, out.circ_size_naive, out.trans_level, def_col('red'))

xlabel(label_for_x)
ylabel(label_for_y)
xlim(out.xlims_naive)
ylim(out.ylims_naive)
set(0,'defaultAxesFontSize', axis_font_size);
abline(0,1,'color',[1,1,1]/2,'linestyle', '-', 'linewidth', 2)
% title(['N = ', groupsize_str,': Circular versus Bootstrap'])
title(['N = ', groupsize_str])

set(gcf, 'position', [500,500,out.height, out.width])
set(gca, 'XTick',out.xtick)
% export_fig([filestart,'.tif'], '-transparent')

end

