%% Transparent Plots

plotXbars( 'mean', 20, 0.5 )
plotXbars( 'tstat', 20, 0.5 )
plotXbars( 'smoothtstat', 20, 0.5 )

plotXbars( 'mean', 50, 0.5 )
plotXbars( 'tstat', 50, 0.5 )
plotXbars( 'smoothtstat', 50, 0.5 )

plotXbars( 'mean', 100, 0.5 )
plotXbars( 'tstat', 100, 0.5 )
plotXbars( 'smoothtstat', 100, 0.5 )
disp('done')
%Script to generate all the Xbar plots.

%%
plotXbars( 'mean', 20 )
plotXbars( 'tstat', 20 )
plotXbars( 'smoothtstat', 20 )

plotXbars( 'mean', 50 )
plotXbars( 'tstat', 50 )
plotXbars( 'smoothtstat', 50 )

plotXbars( 'mean', 100 )
plotXbars('tstat', 100 )
plotXbars( 'smoothtstat', 100 )
disp('done')

%% Optimal Xbar plots
plotOptXbars( 'mean', 20 )
plotOptXbars( 'tstat', 20 )
plotOptXbars( 'smoothtstat', 20 )

plotOptXbars( 'mean', 50 )
plotOptXbars( 'tstat', 50 )
plotOptXbars( 'smoothtstat', 50 )

plotOptXbars( 'mean', 100 )
plotOptXbars('tstat', 100 )
plotOptXbars( 'smoothtstat', 100 )
disp('done')

%%
% plotXbarsTOPTEN( 'mean', 20 )
% plotXbarsTOPTEN( 'tstat', 20 )
% plotXbarsTOPTEN( 'smoothtstat', 20 )
% 
% plotXbarsTOPTEN( 'mean', 50 )
% plotXbarsTOPTEN( 'tstat', 50 )
% plotXbarsTOPTEN( 'smoothtstat', 50 )
% disp('done')
% 
% 
%%
plotXbarsMAX( 'mean', 20 )
plotXbarsMAX( 'tstat', 20 )
plotXbarsMAX( 'smoothtstat', 20 )

plotXbarsMAX( 'mean', 50 )
plotXbarsMAX( 'tstat', 50 )
plotXbarsMAX( 'smoothtstat', 50 )

plotXbarsMAX( 'mean', 100 )
plotXbarsMAX( 'tstat', 100 )
plotXbarsMAX( 'smoothtstat', 100 )
disp('done')

%%
plotXbars('glmsex', 20 )
plotXbars('glmsex', 50 )

%%
plotOptXbars('glmsex', 20 )
plotOptXbars('glmsex', 50 )

