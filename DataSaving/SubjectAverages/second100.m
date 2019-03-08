nsubj = 100;
Agevar = bbvars( 'Age', 0 );
xvar = Agevar(101:(101+nsubj-1));
nsubjover2 = nsubj/2;
smoothed_data = zeros([nsubj, prod(stdsize)]);

for I = 1:nsubj
   img = readvbm(I+100);
   smoothed_data(I,:) = img(:); 
end

imgsave(mean(smoothed_data), 'vbm_estimated_2nd100_mean')