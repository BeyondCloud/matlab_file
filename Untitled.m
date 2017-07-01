Fs = 20000 ;
duration = 0.001 ;
t = 0: 1/Fs:duration-(1/Fs) ;
f  = 1000 ;
Npoint_fft = 256 ;

% creation and plotting of signal of 1KHz
y = sin (2 * pi * f * t) ;
plot (t,y)

% 256 point fft
y_fft = fft(y,256) ;

% plotting of spectra
p  = abs(y_fft.^2) ;
df = Fs/Npoint_fft ;
ff = 0:df:Fs/2-df ;
figure
plot (ff,p(1:end/2))