EMOTION = filesindir('/data/fireback/davenpor/Data/HCP/EMOTION');
MOTOR = filesindir('/data/fireback/davenpor/Data/HCP/EMOTION');
WM = filesindir('/data/fireback/davenpor/Data/HCP/EMOTION');
GAMBLING = filesindir('/data/fireback/davenpor/Data/HCP/EMOTION');

isequal(EMOTION, WM) + isequal(EMOTION, GAMBLING) + isequal(EMOTION, MOTOR)
%The above equals 3 so they are all the same!