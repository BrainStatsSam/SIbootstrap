function dilated_mask = dilatemask( mask, nvox )
% DILATE_MASK( mask, nvox ) dilates the mask by 1 voxel.
%--------------------------------------------------------------------------
% ARGUMENTS
% 
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% 
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
global stdsize
dilated_mask = zeros(stdsize);

for I = 1:91
    for J = 1:109
        for K = 1:91
            if mask(I,J,K) == 1
                
            end
            
            dilated_mask(
            
        end
    end
end

end

