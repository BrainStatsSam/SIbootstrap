niters = 100;
vecofmaxima20 = zeros(1, niters);
nsubj = 20;
for I = 1:niters
    I
    whichsubs = randsample(4945,nsubj);
    data = loadsubs(whichsubs, 'copes');
    data_mean = mean(data);
    vecofmaxima20(I) = max(data_mean(:));
end


%%
niters = 100;
vecofmaxima50 = zeros(1, niters);
nsubj = 50;
for I = 1:niters
    I
    whichsubs = randsample(4945,nsubj);
    data = loadsubs(whichsubs, 'copes');
    data_mean = mean(data);
    vecofmaxima50(I) = max(data_mean(:));
end


%%
niters = 100;
vecofmaxima100 = zeros(1, niters);
nsubj = 100;
for I = 1:niters
    I
    whichsubs = randsample(4945,nsubj);
    data = loadsubs(whichsubs, 'copes');
    data_mean = mean(data);
    vecofmaxima100(I) = max(data_mean(:));
end
save(jgit('AnalyzeData/samplemaximavec.mat'), 'vecofmaxima100', 'vecofmaxima20', 'vecofmaxima50')

%%
% histogram(vecofmaxima20)
% histogram(vecofmaxima50)
% histogram(vecofmaxima100)