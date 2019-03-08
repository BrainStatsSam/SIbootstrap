clear 

mos = imgload('fullmoszeroed');

mos(mos < 0) = 0;

maxloc = lmindices(mos, 1);

h = surf(mos(:,:,26))

aH = ancestor(h,'axes');
set(aH,'XLim',[0 109]);
set(aH,'YLim',[0 91]);
set(aH,'ZLim',[0 1.6]);

set(gca,'fontsize',18)
%Axis Labels
xlabel('y'); ylabel('x'); zlabel('Cohen''s d')

set(gcf, 'position', [0,0,700,500])

%%
export_fig(jgit('Plots/OHBMplots/fullmos.pdf'), '-transparent')

%%
small_sample = imgload('3rd50mos');
small_sample(small_sample < 0) = 0;

h = surf(small_sample(:,:,26))

aH = ancestor(h,'axes');
set(aH,'XLim',[0 109]);
set(aH,'YLim',[0 91]);
set(aH,'ZLim',[0 1.6]);

set(gca,'fontsize',20)
%Axis Labels
xlabel('y'); ylabel('x'); zlabel('Cohen''s d')

set(gcf, 'position', [0,0,700,500])

%%
export_fig(jgit('Plots/OHBMplots/50subjectmos.pdf'), '-transparent')