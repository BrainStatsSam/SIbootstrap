%Check to see whether the fmri subjects are in the vbm list. Turns out its
%all of them!

fmri_subjects = loaddata('subjlist');
vbmsubjlist = loaddata('vbmsubjlist');

subjects_in_both = intersect(fmri_subjects, vbmsubjlist);