mask = imgload('MNImask');

first_data = zeros([25, 91*109*91]);
J = 0;
for I = 51:75
    J = J + 1;
    img = readimg(I);
    first_data(J,:) = img(:);
end
[ ~, ~, first_mos ] = meanmos( first_data, 1, 1);
first_mos = first_mos.*mask;

second_data = zeros([25, 91*109*91]);
J = 0;
for I = 76:100
    J = J + 1;
    img = readimg(I);
    second_data(J,:) = img(:);
end
[ ~, ~, second_mos ] = meanmos( second_data, 1, 1);
second_mos = second_mos.*mask;

overall_data = zeros([50, 91*109*91]);
J = 0;
for I = 51:100
    J = J + 1;
    img = readimg(I);
    overall_data(J,:) = img(:);
end
[ ~, ~, overall] = meanmos( overall_data, 1, 1);
overall = overall.*mask;

true = imgload('mos');
[ est , estwas, trueval, top_lm_indices ] = tbias(1, 20, 50, overall_data, true(:)' , 1);

[ est2, trueval2, top_lm_indices2 ] = tindepsplit( overall_data, 20, true(:)', 1);

if strcmp(TYPE, 'jala')
    imgsave( first_mos, '2nd50firstmos', strcat(jalaloc,'Viewing/CombinedSubjectImages') )
    imgsave( second_mos, '2nd50secondmos', strcat(jalaloc,'Viewing/CombinedSubjectImages') )
    imgsave( overall, '2nd50overallmos', strcat(jalaloc,'Viewing/CombinedSubjectImages') )
end
    
