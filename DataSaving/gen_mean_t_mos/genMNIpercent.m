%This gives the percent mask restricted to the MNI brain.

permask = imgload('percent');
MNImask = imgload('MNImask');

perMNImask = permask.*MNImask;

global davenpor
imgsave(perMNImask, 'perMNImask', strcat(davenpor,'jalagit/Viewing/CombinedSubjectImages'))