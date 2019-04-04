types = {'mean', 'tstat', 't4lm', 'R2'};
types = {'R2'}
% [70,80,90,100,30,40,60,70,80,90,100];
% [30,40,60,70,90,100];
% [30,40,70,90,100,30,40,70,90];
for type = types
    disp(type{1})
    stored = zeros(2*4,3);
    I = 1;
    for FWHM = [3,6]
        for nsubj = 10:10:100;
            stored(I, 1) = nsubj;
            stored(I, 2) = FWHM;
            try 
                if strcmp( type{1}, 'mean2')
                    load(['/Users/SamD/davenpor/davenpor/SubmittedCode/SIbootstrap/Sims/',type{1},'Thresh/B100sd1FWHM', num2str(FWHM),'nsubj', num2str(nsubj),'SIMSversion2.mat'])
                else
                    load(['/Users/SamD/davenpor/davenpor/SubmittedCode/SIbootstrap/Sims/',type{1},'Thresh/B100sd1FWHM', num2str(FWHM),'nsubj', num2str(nsubj),'SIMS.mat'])
                end
                stored(I, 3) = A(end,1);
            catch
                stored(I, 3) = NaN;
            end
            I = I+1;
        end
    end
end
stored