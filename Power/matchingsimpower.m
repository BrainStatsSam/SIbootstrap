% This file derives the beta required to acheive a similar power to the one-sample 
% t simulations with the GLM simulations, see the supplementary material.

p = 2;
beta = 0.5822;
f2 = beta^2;
alpha = 0.05;
N = 30;

falphaquantile = finv(1-alpha, 1, N-p);
power = 1 - ncfcdf(falphaquantile, 1, N-p, N*f2)

%%
Cohensd = 0.5;

talphaquantile = norminv(1-alpha, 0, 1);
power = 1 - normcdf(talphaquantile, sqrt(N)*Cohensd, 1)