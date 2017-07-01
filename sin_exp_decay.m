clc;
clear;
fs=44100;
length = 0.5;
f1 = linspace(440 ,220 ,fs*length);
%f2 = linspace(220 ,440 ,fs*length);

t = linspace(0 ,length ,fs*length);
y1=sin( 2 * pi * f1 .* t) .* exp(-3*t);
y2=sin( 2 * pi * 220 .* t) .* exp(-3*t);
y3 = y1+y2;
subplot(3,1,1)
plot(y1);
subplot(3,1,2)
plot(y2);
subplot(3,1,3)
plot(y3);
sound(y3,44100);

%end
% fs = 44100; % Hz
% t = 0:1/fs:5; % seconds
% f = 440; % Hz
% y = sin(2.*pi.*f.*t);
% sound(y,fs,16);