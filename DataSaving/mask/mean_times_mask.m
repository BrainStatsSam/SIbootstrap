%Needs to be run on JALAPENO!
%Applies the total mask to the random mean.

if ~strcmp(TYPE, 'jala')
    error('Needs to be run on jalapeno')
end

r_mean_img = imgload('mean');
mask = imgload('mask');
rmeanmask = r_mean_img.*mask;

imgsave(rmeanmask, 'rmeanmask', parloc)