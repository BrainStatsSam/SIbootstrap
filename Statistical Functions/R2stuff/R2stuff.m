n = 1000;
sigma = sqrt(0.03);
mu = 0.005;
mos = mu/sigma;
p = 2;
tstat = sqrt(n)*mos;

R2_est = 1 - 1/((p-1)/(n-p)*tstat^2 +1)

mos = 0.63
R2_est = 1 - 1/(1+mos^2)
