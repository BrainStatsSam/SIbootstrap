som = imgload('SOM');
MNImask = imgload('MNImask');

a = som.*MNImask;

a = a(a>0);

min(a)