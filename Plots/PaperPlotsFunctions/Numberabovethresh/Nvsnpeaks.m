function Nvsnpeaks( type, which_N )
% NVSNPEAKS( type, which_N )
%--------------------------------------------------------------------------
% ARGUMENTS
% type      either 'tstat' or 'Fstat'
%--------------------------------------------------------------------------
% OUTPUT
% 
%--------------------------------------------------------------------------
% EXAMPLES
% NVSNPEAKS('tstat', 10:10:100 )
%--------------------------------------------------------------------------
% AUTHOR: Sam Davenport.

tot_subj = 4945;

temp = load(strcat(jgit('Plots/PaperPlots/Numberabovethresh/'), type, '_peaknumbers.mat'));
nstore = temp.nstore;

cont_keys = cell2mat(keys(nstore.npeaks));
which_N_2use = setdiff(which_N, cont_keys);


for I = 1:length(which_N_2use)
    N = which_N_2use(I);
    npeaks = 0;
    ncomps = 0;
    number_above_thresh = 0;
    for real = 1:floor(tot_subj/N)
        fprintf('N = %i, real = %i/%i\n', N, real, floor(tot_subj/N))
        which_subs = ((real-1)*N + 1):(real*N);
        data = loadsubs(which_subs, 'copes');
        masks = loadsubs(which_subs, 'mask');
        subject_mask = gen_mask(masks);
        out = RFthresh(data, subject_mask);
        npeaks = npeaks + out.npeaks_above_thresh;
        ncomps = ncomps + out.ncomps_above_thresh;
        number_above_thresh = number_above_thresh + out.number_above_thresh;
    end
    nstore.npeaks(N) = npeaks;
    nstore.ncomps(N) = ncomps;
    nstore.nabovethresh(N) = number_above_thresh;
end

save(strcat(jgit('Plots/PaperPlots/Numberabovethresh/'), type, '_peaknumbers.mat'), 'nstore');

end

