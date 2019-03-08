clear

which_subs = 1:50;
Agevar = bbvars( 'Age', 0 );
xvar = Agevar(which_subs);
data = loadsubs(which_subs, 'vbm');
mask = imgload('vbm_mask');

[nSubj, nVox] = size(data);
[ ~, ~, est_std_residuals, est_fitted, est_R2, est_t ] = MVlm( xvar', data );

Fstat = est_t.^2;
fwhm_est = est_smooth(reshape(est_std_residuals', [91,109,91, nSubj]));
resel_vec = spm_resels_vol(mask, fwhm_est)';

threshold = spm_uc( 0.05, [1,(nSubj-1)], 'F', resel_vec, 1 );
mask_of_greater_than_threshold = Fstat > threshold;
mask_of_greater_than_threshold = reshape(mask_of_greater_than_threshold, [91,109,91]).*mask;
top = numOfConComps(mask_of_greater_than_threshold, 0.5, 3);

top_lm_indices = lmindices(Fstat,top, mask);