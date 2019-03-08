FWHM_vec = 0:0.5:6;
nentries = length(FWHM_vec);
thresh = 1;
for type = {'tstat','t4lm'};
    for s = 1
        for groupsize = [20,50]
            isbias = zeros(1, nentries);
            ismse = zeros(1, nentries);
            bootbias = zeros(1, nentries);
            bootmse = zeros(1, nentries);
            naivebias = zeros(1, nentries);
            naivemse = zeros(1, nentries);
            
            if thresh == 0
                for I = 1:nentries
                    out = dispres_sims(type{1}, groupsize, s, FWHM_vec(I));
                    isbias(I) = out.biasis;
                    ismse(I) = out.mseis;
                    naivebias(I) = out.biasnaive;
                    naivemse(I) = out.msenaive;
                    bootbias(I) = out.biasboot;
                    bootmse(I) = out.mseboot;
                end
            elseif thresh == 1
                for I = 1:nentries
                    version = 2;
                    out = dispres_sims_thresh(type{1}, groupsize, s, FWHM_vec(I), version, 0 , 0);
                    isbias(I) = mean(out.biasis);
                    ismse(I) = mean(out.mseis);
                    naivebias(I) = mean(out.biasnaive);
                    naivemse(I) = mean(out.msenaive);
                    bootbias(I) = mean(out.biasboot);
                    bootmse(I) = mean(out.mseboot);
                end
            end
            
            clf
            plot( 2*FWHM_vec, naivebias, 'linewidth', 2, 'Color', def_col('red'))
            hold on
            plot( 2*FWHM_vec, isbias, 'linewidth', 2,'Color', def_col('blue'))
            plot( 2*FWHM_vec, bootbias, 'linewidth', 2,'Color', def_col('yellow'))
            xlabel('FWHM in mm')
            ylabel('Bias')
            xlim([0,2*FWHM_vec(end)])
            title(['Bias for N = ', num2str(groupsize)])
            if groupsize == 20
                legend('Circular', 'Data-Splitting', 'Bootstrap' )
            end
            set(gca,'fontsize', 20)
            if thresh
                export_fig(strcat('~/global/TomsMiniProject/Matlab/Sims/PlotSims/', type{1}, 'Thresh/', type{1}, '_biasSD',num2str(s), 'groupsize', num2str(groupsize)), '-transparent')
            else
                export_fig(strcat('~/global/TomsMiniProject/Matlab/Sims/PlotSims/', type{1}, '/', type{1}, '_biasSD',num2str(s), 'groupsize', num2str(groupsize)), '-transparent')
            end
            
            clf
            plot( 2*FWHM_vec, naivemse, 'linewidth', 2, 'Color', def_col('red'))
            hold on
            plot( 2*FWHM_vec, ismse, 'linewidth', 2,'Color', def_col('blue'))
            plot( 2*FWHM_vec, bootmse, 'linewidth', 2,'Color', def_col('yellow'))
            xlabel('FWHM in mm')
            ylabel('MSE')
            xlim([0,2*FWHM_vec(end)])
            title(['MSE for N = ', num2str(groupsize)])
            %         legend('Data-Splitting', 'Circular', 'Bootstrap' )
            set(gca,'fontsize', 20)
            if thresh
                export_fig(strcat('~/global/TomsMiniProject/Matlab/Sims/PlotSims/', type{1}, 'Thresh/', type{1}, '_mseSD',num2str(s), 'groupsize', num2str(groupsize)), '-transparent')
            else
                export_fig(strcat('~/global/TomsMiniProject/Matlab/Sims/PlotSims/', type{1}, '/', type{1}, '_mseSD',num2str(s), 'groupsize', num2str(groupsize)), '-transparent')
            end
            
            clf
            plot( 2*FWHM_vec, (naivemse - naivebias.^2), 'linewidth', 2, 'Color', def_col('red'))
            hold on
            plot( 2*FWHM_vec, (ismse-isbias.^2), 'linewidth', 2, 'Color', def_col('blue'))
            plot( 2*FWHM_vec, (bootmse - bootbias.^2), 'linewidth', 2,'Color', def_col('yellow'))
            xlabel('FWHM in mm')
            ylabel('Variance')
            xlim([0,2*FWHM_vec(end)])
            title(['Variance for N = ', num2str(groupsize)])
            %         legend('Data-Splitting', 'Circular', 'Bootstrap' )
            set(gca,'fontsize', 20)
            if thresh
                export_fig(strcat('~/global/TomsMiniProject/Matlab/Sims/PlotSims/', type{1}, 'Thresh/', type{1}, '_varSD',num2str(s), 'groupsize', num2str(groupsize)), '-transparent')
            else
                export_fig(strcat('~/global/TomsMiniProject/Matlab/Sims/PlotSims/', type{1}, '/', type{1}, '_varSD',num2str(s), 'groupsize', num2str(groupsize)), '-transparent')
            end
        end
    end
end