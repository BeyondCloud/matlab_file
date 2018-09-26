clear;clc;
N = 440;
% t = (1:N);
% f = 162.324;
% x = cos(2*pi*f*t/fs);
%%%%%%%
[x,fs] = audioread('my_a.wav');
k = 100;
x = x(k:k+N-1);
p.synHop = 128;
p.win = win(512,2); % hann window
p.tolerance = 256;
x = wsolaTSM(x,2.0,p);

N = length(x);
%%%%%%%%
X = abs(fft(x))';
X = X(1:N/2+1);
f_x = fs*(0:(N/2))/N;
[~, max_i] = max(X);
disp(f_x(max_i));
del = 10^(ceil(log10(f_x(max_i+1)-f_x(max_i))));


