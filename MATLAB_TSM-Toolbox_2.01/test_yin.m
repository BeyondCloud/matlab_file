amp=0.3;
fs=44100;  % sampling frequency
duration=2;
a = 400;
b = 200;
t = linspace(0, 2, fs*duration);
x=amp*chirp(t, a, t(end), b)';
param.sr = fs;
param.hop = 1;
[f0 t] = yin_f0(x,param);
truef =  linspace(a, b, fs*duration);