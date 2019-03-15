global stdsize
stdsize = [91, 109, 91];

global SimsDir
SimsDir = '/data/greyplover/not-backed-up/oxwasp/oxwasp16/davenpor/Sims/';

global server_dir
if strfind(pwd, 'greyplover')
    server_dir = '/data/greyplover/not-backed-up/oxwasp/oxwasp16/davenpor/';
elseif strfind(pwd, 'greyheron')
    server_dir = '/data/greyheron/not-backed-up/oxwasp/oxwasp16/davenpor/';
elseif strfind(pwd, 'greypartridge')
    server_dir = '/data/greypartridge'/not-backed-up/oxwasp/oxwasp16/davenpor/';
elseif strfind(pwd, 'greyostrich')
    server_dir = '/data/greyostrich/not-backed-up/oxwasp/oxwasp16/davenpor/';
end

addpath(genpath(server_dir))