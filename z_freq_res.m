clc;
clear;
b0 = 0.05634;
b1 = [1 0 0 0 1];
a1 = [1 ];

[h,w] = freqz(b1,a1,'whole',2001);
plot(w/pi,20*log10(abs(h)))
ax = gca;
ax.YLim = [-100 20];
ax.XTick = 0:.5:2;
xlabel('Normalized Frequency (\times\pi rad/sample)')
ylabel('Magnitude (dB)')