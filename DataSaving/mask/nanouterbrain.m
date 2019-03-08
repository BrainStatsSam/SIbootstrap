%% Create an image which is NAN outside the brain and 1 inside the brain.

MNImask = imgload('MNImask');
MNImaskNAN = zero2nan(MNImask);
imgsave(MNImaskNAN, 'MNImaskNAN', 2);
