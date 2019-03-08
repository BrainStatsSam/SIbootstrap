addpath /opt/fmrib/fsl/etc/matlab ~steve/NETWORKS/FSLNets ~steve/matlab/FastICA_25 ~steve/matlab ~steve/matlab/FACS

load('/vols/Data/ukbiobank/FMRIB/ANALYSIS/workspace5b.mat')

%%%%%%%%%%%%%%%%%%%% categories
% 1  age, sex, brain MRI protocol Phase
% 2  genetics
% 3  early life factors
% 10 lifestyle and environment - general
% 11 lifestyle and environment - exercise and work
% 12 lifestyle and environment - food and drink
% 13 lifestyle and environment - alcohol
% 14 lifestyle and environment - tobacco
% 20 physical measures - general
% 21 physical measures - bone density and sizes
% 22 physical measures - cardiac & blood vessels
% 23 hearing test
% 24 eye test
% 25 physical activity measures
% 30 blood assays
% 31 brain IDPs
% 32 cognitive phenotypes
% 50 health and medical history, health outcomes
% 51 mental health self-report
% 99 misc, ignored

vt{1}=[31 34 22200 25780];
%vt{2}=[21000 22000:22125 22201:22325];
%vt{3}=[52 129 130 1677 1687 1697 1737 1767 1777 1787 20022];
%vt{10}=[3:6 189 680 699 709 728 738 1031 1797 1807 1835 1845 1873 1883 2139 2149 2375 2385 2395 2405 2267 ...
%        2277 2714:10:2834 2946 3526 3536 3546 3581 3591 3659 3669 3700 3710 3720 3829 3839 3849 3872 3882 3912 3942 3972 3982 4501 4674 4825 4836 5057 ...
%        6138 6142 6139:6141 6145:6146 6160 10016 10105 10114 10721 10722 10740 10749 10860 10877 10886 ...
%        20074:20075 20110:20113 20118:20119 20121 22501 22599 22606 22700 22702 22704];
%vt{11}=[1001 1011 767 777 796 806 816 826 845 864 874 884 894 904 914 924 943 971 981 991 1021 1050:10:1220 2624 2634 ...
%        3426 3637 3647 6143 6162 6164 10953 10962 10971 22604 22605 22607:22615 22620 22630 22631 22640:22655 104900 104910 104920];
%vt{12}=[1289:10:1389 1408:10:1548 2654 3680 6144 10007 10767 10776 10855 10912 20084:20094 20098:20109 100001:100009 100011:100019 100021:100025 ...
%        100010:10:100560 100760:10:104670];
%vt{13}=[1558:10:1628 2664 3731 3859 4407 4418 4429 4440 4451 4462 5364 20095:20097 20117 100580:10:100740];
%vt{14}=[1239:10:1279 2644 2867:10:2907 2926 2936 3159 3436:10:3506 5959 6157 6158 6183 6194 20116 22506:22508];
%vt{20}=[46:50 1707 1717 1727 1747 1757 2306 3062:3065 3088 3089 3160 10691 10694:10696 20015 21001 21002 22400:22410 22427 23098:23130 23244:23289];
%vt{21}=[77 78 3083:3085 3143:3144 3148 4100:4101 4104:4106 4119:4120 4124:4125 4138:4139 4141 4143:4144 4146 23200:23243 23290:23320];
vt{22}=[93:95 102 4079 4080 4194 4195 4196 5983 5984 5986 5992 5993 6019 6020 6022 6024 6032:6034 6038 6039 ...
        12673:12687 12697 12698 12702 21021 22420:22426];
%vt{23}=[4229 4230 4232 4233 4236 4240:4244 4268:4270 4275:4277 10793 20019 20021];
%vt{24}=[5084:5089 5096:5099 5101 5103:5119 5132:5135 5149 5155:5164 5181 5198 5221 5237 5251 5254:5257 5262:5265 5276 5292 5306 5324:5325 5327 6070 6072];
%vt{25}=[90002:90003 90012 90013 90015 90019:90083 90086:90089 90091:90150 90159:90177 90179 90182:90195];
%vt{30}=[74 30000:10:30300 30172 30174 30242 30252 30254];
%vt{31}=[25000:25746 25761:25768 25781:25920];
vt{32}=[111 398:404 630 4250:4252 4254:4256 4258:4259 4282:4283 4285:4286 4288 4290:4292 4957 4968 4979 4990 5001 5012 5556 5699 5779 5790 5866 ...
        10137:10141 10144 10146:10147 10241 10609 10612 20016 20018 20023 20082 20128:20157 20159 20169:2:20191 20195 20196 20198 20200 ...
        20229 20230 20240 20242 20244:20248];
vt{50}=[84 87 92 134:137 2178 2188 2207:10:2257 2296 2316 2335:10:2365 2415 2443:10:2473 2492 2674 ...
        2684 2704 2844 2956:10:2986 3005 3079 3140 ...
        3393 3404 3414 3571 3606 3616 3627 3741 3751 3761 3773 3786 3799 3809 3894 3992 ...
        4012 4022 4041 4056 4067 4689 4700 4717 4728 4792 4803 4814 5408 5419 5430 5441 5452 5463 5474 5485 5496 5507 ...
        5518 5529 5540 5610 5832 5843 5855 5877 5890 5901 5912 5923 5934 5945 6119 6147 6148 6149 ...
        6150 6151 6152 6153 6154 6155 6159 6177 6179 6205 20001:20011 22126:22181 22502:22505 22616 22618 22619 40001:41253 42000:42013];
vt{51}=[1920:10:2110 4526 4537 4548 4559 4570 4581 4598 4609 4620 4631 4653 5375 5386 5663 5674 6156];
%vt{99}=[19 21 53 54 68 120 132 757 1647 2129 3137 12139 12140 12141 12187 12188 12223 12224 12253 12254 12623 12624 12651 12652 ...
%        12663 12664 12671 12695 12699 12700 12704 12706 12848 12851 12854 ...
%        20012:20014 20024 20049 20053:20054 20061:20062 20077 20078 20083 20115 20158 20201:20227 20249:20253 21003 22499 22500 ...
%        22600:22603 22617 22660:22664 25747:25753 40000 105010 105030 110005 110006];

vt_use=[ 1 22 32 50 51 ];
%vt_not_use=[ 2 3 10:14 20 21 24 25 30 31 99 ];

%%% identify vars of special interest for our work

%age at scan date
dosI=nets_cellfind(varsVARS,'53-2.0'); scan_date=vars(:,dosI); sum(isnan(scan_date))   
  scan_date(isnan(scan_date))=max(scan_date)+0.1; % previously needed with missing dates
yobI=nets_cellfind(varsVARS,'34-0.0'); mobI=nets_cellfind(varsVARS,'52-0.0'); birth_date=vars(:,yobI)+(vars(:,mobI)-0.5)/12;
age=scan_date - birth_date;

sexI=nets_cellfind(varsVARS,'31-0.0');  sex=vars(:,sexI);

%BP variables
BP_diastolic_I=nets_cellfind(varsVARS, '4079-2.0'); BP_diastolic=vars(:,BP_diastolic_I);
BP_systolic_I=nets_cellfind(varsVARS, '4080-2.0'); BP_systolic=vars(:,BP_systolic_I);

%Cognitive function
Cogn_prosp_memory_I=nets_cellfind(varsVARS, '20018-2.0'); Cogn_prosp_memory=vars(:,Cogn_prosp_memory_I);
Cogn_fluid_int_I=nets_cellfind(varsVARS, '20016-2.0'); Cogn_fluid_int=vars(:,Cogn_fluid_int_I);
Cogn_matches_I=nets_cellfind(varsVARS, '20023-2.0'); Cogn_matches=vars(:,Cogn_matches_I);


%Diagnosis
%diag_I=nets_cellfind(varsVARS, '41202'); diag=vars(:,diag_I);
%diag_hypertension_I=nets_cellfind(varsVARS, '41202'); diag_hypertension=vars(:,diag_hypertension_I);

subject_ID  = ALL_IDPs(:,1);
data        = zeros(9933,8);
data        = [subject_ID, age, sex, BP_diastolic, BP_systolic, Cogn_prosp_memory, Cogn_fluid_int, Cogn_matches];

% csvwrite('/vols/Data/ukbiobank/scratch/nichols/initial_data.csv', data)
% dlmwrite('/vols/Data/ukbiobank/scratch/nichols/initial_data.csv', data,'delimiter', ',', 'precision', 9) 
csvwrite(jgit('DataSaving/BiobankVars/subject_vars.csv'), data)
dlmwrite(jgit('DataSaving/BiobankVars/subject_vars_delim.csv'), data,'delimiter', ',', 'precision', 9) 
