function biasvsSS( type, group_sizes )
% biasvsSS( type, increments ) calculates the bias versus the sample size.
%--------------------------------------------------------------------------
% ARGUMENTS
% type          Either 'mean', 'tstat' or 'smoothtstat'.
% group_sizes   A vector of numbers to calculate the bias. Default is
%               5:5:100.
%--------------------------------------------------------------------------
% OUTPUT
% Saves a container.
%--------------------------------------------------------------------------
% EXAMPLE
% biasvsSS( 'mean' )
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
if nargin < 2
    group_sizes = 5:5:100;
end

global stdsize

if strcmp(type, 'mean')
    truth = imgload('fullmean');
else
    truth = imgload('mos');
end

if strcmp(type, 't')
    type = 'tstat';
elseif strcmp(type, 'smootht')
    type = 'smoothtstat';
end

MNImask = imgload('MNImask');

container = loaddata(strcat('biasSS', type));
cont_keys = cell2mat(keys(container));
new_group_sizes = setdiff(group_sizes, cont_keys);

for I = 1:length(new_group_sizes)
    nsubj = new_group_sizes(I);
    niters = floor(4900/nsubj);
    
    mate_of_differences = zeros(niters, 2);
    
    for iter = 1:niters
        fprintf(strcat(num2str(new_group_sizes(I)),':',num2str(iter),'/',num2str(niters),'\n'));
        subcomb = zeros(stdsize);
        
        data = zeros(nsubj, prod(stdsize) );
        mask = zeros(stdsize);
        for n = 1:nsubj
            img = readimg((iter-1)*nsubj + n);
            data(n, :) = img(:);
            mask = mask + readimg((iter-1)*nsubj + n, 'mask');
        end
        mask = (mask == nsubj).*MNImask;
        
        if strcmp(type, 'mean')
            subcomb = mean(data);
        elseif strcmp(type, 'tstat')
            [~, ~, subcomb] = meanmos(data);
        elseif strcmp(type, 'smoothtstat')
            [~, ~, subcomb] = meanmos(data,1);
        end
        
        max_mean_index = lmindices(subcomb, 1, mask);
        
        mate_of_differences(iter,1) = subcomb(max_mean_index);
        mate_of_differences(iter,2) = truth(max_mean_index);
    end
    container(nsubj) = mate_of_differences; %Unused because matlab can't figure out how container is assigned using the save below.
    
    save(strcat('/vols/Scratch/ukbiobank/nichols/SelectiveInf/',type,'MaxvsTruth'), 'container');
end


end

