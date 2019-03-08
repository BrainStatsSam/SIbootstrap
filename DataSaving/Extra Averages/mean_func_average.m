%average the mean_func images over all subjects.
%The mean_func images are the mean of all the images from the tfMRI time series.

global stdsize
mean_func_av = zeros(stdsize);
N = 8945;
for I=1:N
    mean_func_av = mean_func_av + readimg(I,'mean_func',1);
    if mod(I,100) == 0
        disp(I);
    end
end

mean_func_av = mean_func_av/N;
global parloc
imgsave( mean_func_av, 'mean_func_average', parloc)