dilmask = imgload('MNImaskdil');

dilmaskNAN = zero2nan(dilmask);

imgsave(dilmaskNAN, 'MNImaskdilNAN')