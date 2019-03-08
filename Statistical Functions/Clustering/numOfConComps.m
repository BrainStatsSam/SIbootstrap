%==========================================================================
% This file counts the number of connected components in an excursion set.
% It takes in:
%
% sim - the simulated data.
% thresh - the threshold value.
% D - the dimension of the data.
%
% And returns:
%
% truem - the number of connected components in the script.
%
% Authors: Tom Maullin, Samuel Davenport (05/02/2018)
%
% EXAMPLES
% simul = randn(10,10)
% thresh = 1.5;
% simul > thresh
% numOfConComps(simul, thresh, 2)
%==========================================================================
function [truem, occurences, sizes] = numOfConComps(sim, thresh, D)
    %Remove values below threshold.
    sim(sim<=thresh) = 0;


    %If we're in the 2d case only look at components connected vertically
    %and horizontally (i.e. no diagonals!)
    if D == 2     
        conComponents = bwconncomp(sim, 4);
    elseif D == 3
        conComponents = bwconncomp(sim, 18);
    else
        error('Nope');
    end 
    
    %Return the true number of connected components/clusters.
    truem = conComponents.NumObjects;
    
    if nargout > 1
    
        %Get a list of sizes of the clusters.
        sizeArray = cellfun(@(x) numel(x), conComponents.PixelIdxList);

        %Get the number of occurences for each cluster size. e.g. occurences(k)
        %is the number of times we observed clusters of size sizes(k).
        [occurences, sizes] = hist(sizeArray, unique(sizeArray));
        
    end
    
end