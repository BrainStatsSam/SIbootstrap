%Does work on jalapeno!
plot(1:10,1:10)

str =  '/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/test1.pdf';
export_fig(str, '-transparent') %This works

% But this doesn't:
str2 = jgit(strcat('Plots/PaperPlots/BiasSSplots/', 'test', '2.pdf'));
export_fig(str2,'-transparent')

export_fig(jgit(strcat('Plots/PaperPlots/BiasSSplots/', 'test', '3.pdf')),'-transparent')

str3 = strcat( '/vols/Scratch/ukbiobank/nichols/SelectiveInf/jalagit/Plots/PaperPlots/BiasSSplots/test','4.pdf');
export_fig(str3,'-transparent')

str
str2
str3

% cd Plots/PaperPlots/BiasSSplots


%This works on my machine:
% plot(1:10,1:10)
% 
% str =  '/data/fireback/davenpor/davenpor/jalagit/Plots/PaperPlots/BiasSSplots/test1.pdf';
% export_fig(str, '-transparent') %This works
% 
% % But this doesn't:
% str2 = jgit(strcat('Plots/PaperPlots/BiasSSplots/', 'test', '2.pdf'));
% export_fig(str2,'-transparent')
% 
% str3 = strcat( '/data/fireback/davenpor/davenpor/jalagit/Plots/PaperPlots/BiasSSplots/test','3.pdf');
% export_fig(str3,'-transparent')
% 
% str
% str2
% str3

