global CSI
MNImask = imgload('MNImask');
data = loadsubs(1001:1050, 'cope', 1);

[ ~, ~, mos1 ] = meanmos( data(1:25, :), 0, 1, 1);
[ ~, ~, mos2 ] = meanmos( data(26:50, :), 0, 1, 1);

imgsave( mos1, '21stfirst25mosZERO', [CSI,'Figures/'] )
imgsave( mos2, '21stsecond25mosZERO', [CSI,'Figures/'] )

[ ~, ~, mos ] = meanmos( data, 0, 1, 1);
imgsave( mos, '21st50mosZERO', [CSI,'Figures/'] )

%%
% global CSI
% MNImask = imgload('MNImask');
% data = loadsubs(1001:1050, 'cope', 1);
% 
% [ ~, ~, mos1 ] = meanmos( data(1:25, :), 0, 1, 1);
% [ ~, ~, mos2 ] = meanmos( data(26:50, :), 0, 1, 1);
% 
% imgsave( mos1, '21stfirst25mosZERO', [CSI,'Figures/'] )
% imgsave( mos2, '21stsecond25mosZERO', [CSI,'Figures/'] )
% 
% [ ~, ~, mos ] = meanmos( data, 0, 1, 1);
% imgsave( mos, '21st50mosZERO', [CSI,'Figures/'] )