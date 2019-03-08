function array_of_images = LD_preprocess( design_matrix, brain_paths, mask_paths, save )
% LD_preprocess calculates the variable times y images for each of the
% images. Below let n denote the number of subjects and p the number of
% regressors.
%--------------------------------------------------------------------------
% ARGUMENTS
% design_matrix An nxp matrix.
% brain_paths   A csv file where the nth line is the path to the brain
%                   nifti file of the nth subject.
% mask_paths    A csv file where the nth line is the path to the nifti 
%                   file corresponding to the mask of the brain of the nth 
%                   subject.
% save          0/1 whether to save the images to files or not.
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% 
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.
sX = size(design_matrix);
n = sX(1);
p = sX(2);

if p > 10
    warning('The number of regressors is quite large, you may run into memory problems');
end

brain_path_fid = fopen(brain_paths, 'r');
mask_path_fid =  fopen(mask_paths,'r');

brain_string_paths = textscan(brain_path_fid,'%s','delimiter','\n');
mask_string_paths = textscan(mask_path_fid,'%s','delimiter','\n');

XtX = cell(p,p);

for subj = 1:n
    
end

end

