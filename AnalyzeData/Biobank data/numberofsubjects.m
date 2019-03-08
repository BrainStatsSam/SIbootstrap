img = imgload('nsubs4000mask');
sorted_img = sort(img(~isnan(img)));

sorted_img(1:100)

len = length(sorted_img);
sum(sorted_img > 100)/len
sum(sorted_img > 3000)/len