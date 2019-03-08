N = 1:100;
alpha = 0.05;
cohensd = 1.519;
naive = powerCalc( N, cohensd, alpha);
correctedCD = 1.161;
corrected = powerCalc( N, correctedCD, alpha );

plot(N, naive, 'LineWidth', 2);
hold on
plot(N, corrected, 'LineWidth', 2);

%%
clf
pos_vector = [0,550,800,600];
set(0,'defaultAxesFontSize', 20);
set(gcf, 'position', pos_vector)

N = 1:80;
MNImask = imgload('MNImask');
nvox = sum(MNImask(:));
% alpha = 0.05/nvox;
alpha = 1-tcdf(5.10, 79); %Ie alpha approx= 1.138*10^-6
cohensd = 1.519;
naive = powerCalc( N, cohensd, alpha );
correctedCD = 1.161;
corrected = powerCalc( N, correctedCD, alpha );

plot(N, naive*100, 'LineWidth', 2);
hold on
plot(N, corrected*100, 'LineWidth', 2);
xlabel('N: Number of Subjects')
ylabel('Corresponding Power (%)')
title('Power versus Sample Size')
legend('Cohen''s d = 1.519', 'Cohen''s d = 1.161', 'Location', 'SouthEast')

export_fig(jgit('/Plots/PaperPlots/Power/powerCD.pdf'), '-transparent')
%%
clf
N = 1:100;
alpha = 0.05;
cohensd = 0.979;
naive = powerCalc( N, cohensd, alpha);
correctedCD = 0.807;
corrected = powerCalc( N, correctedCD, alpha );

plot(N, naive, 'LineWidth', 2);
hold on
plot(N, corrected, 'LineWidth', 2);

% export_fig(jgit('/Plots/PaperPlots/Power/'), '-transparent')

%%
clf
N = 1:100;
alpha = 2*10^-7;
cohensd = 0.979;
naive = powerCalc( N, cohensd, alpha );
correctedCD = 0.807;
corrected = powerCalc( N, correctedCD, alpha );

plot(N, naive, 'LineWidth', 2);
hold on
plot(N, corrected, 'LineWidth', 2);
xlabel('N: Number of Subjects')
ylabel('Corresponding Power')
title('Power versus Sample Size at a 5% familywise brain wide error level')
% 
% N = 0:1500;
% R2_uncorrected = 0.0368;
% R2_corrected = 0.0061;
% power_uncorrected = powerCalc(N, 16, R2_uncorrected);
% power_corrected = powerCalc(N, 16, R2_corrected);
% 
% plot(power_uncorrected, N, 'LineWidth', 2)
% hold on
% plot(power_corrected, N, 'LineWidth', 2)
% xlabel('Desired Power') 
% ylabel('Number of Subjects Needed')
% title('Power vs Number of Subjects for \alpha = 0.05')
% legend('Uncorrected', 'Corrected', 'Location', 'northwest')
% 
% export_fig(jgit(strcat('Plots/PaperPlots/Power/powergraph.pdf')), '-transparent')
