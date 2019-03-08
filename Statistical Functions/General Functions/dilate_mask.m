mask = 4;
[a,b,c] = ndgrid(-1:1);
se = strel('arbitrary',sqrt(a.^2 + b.^2 + c.^2) <=1);
dilated_mask = imdilate(mask, se);
