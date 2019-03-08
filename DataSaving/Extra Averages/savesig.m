% Save the signal for the local 3D simulations that you have.

Sig = gensig(3, 6, 3, 20);
global where_davenpor
imgsave( Sig, 'Sig', strcat(where_davenpor,'exampledata/') )