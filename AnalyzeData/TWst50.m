% %% Mask nans zero
% first_half = imgload('Samples/21stfirst25mosnan');
% second_half = imgload('Samples/21stsecond25mosnan');
% whole = imgload('Samples/21st50mos');
% mask = imgload('Samples/21st50mask');
% 
% imgsave(nan2zero(first_half).*mask, 'Samples/21stfirst25mosZERO')
% imgsave(nan2zero(second_half).*mask, 'Samples/21stsecond25mosZERO')
% imgsave(nan2zero(whole).*mask, 'Samples/21st50mosZERO')


%%
first_half = imgload('Samples/21stfirst25mosZERO');
mask = imgload('Samples/21st50mask');
second_half = imgload('Samples/21stsecond25mosZERO');
whole = imgload('Samples/21st50mosZERO');
fullmos = imgload('fullmos');

max_index = lmindices(first_half, 1, mask);
convind(index,1);
first_half(max_index)
second_half(max_index)
fullmos(max_index)

whole_index = lmindices(whole);
convind(whole_index,1);
whole(whole_index)
fullmos(whole_index)

%% Masking
data = getsubs(50,21,'copes');
masks = getsubs(50, 21, 'mask');

subject_mask = gen_mask(masks);
imgsave(subject_mask, 'Samples/21st50mask');
%%
mask = imgload('Samples/21st50mask');