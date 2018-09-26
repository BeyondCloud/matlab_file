clear;clc;
fs = 1000;
N = 1000;
t = (1:N);
f = 16.2324;
x = cos(2*pi*f*t/fs);
X = abs(fft(x))';
X = X(1:N/2+1);
f_x = fs*(0:(N/2))/N;
[~, max_i] = max(X);
disp(f_x(max_i));


