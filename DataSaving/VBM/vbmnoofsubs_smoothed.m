global stdsize
no_of_subs = zeros(stdsize);

for I = 1:8945
    I
    no_of_subs = (readvbm(I,1) ~= 0) + no_of_subs;
end

imgsave(no_of_subs, 'vbm_noofsubs_smoothed')

%This is basically 8945 most places which is good!