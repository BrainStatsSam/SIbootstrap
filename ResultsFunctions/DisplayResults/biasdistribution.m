% Looking at the distribution of the biases.

[~,biasnaive,biasis] = loadres('mean',20);

plot(biasis(1:20:(20*100)))