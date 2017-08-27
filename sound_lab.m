clc;
clear;
fs=44100;
length = 1;
%f1 = linspace(440 ,440 ,fs*length);
r = 2*rand(1,fs*length,'double')-1;
t = linspace(0 ,length ,fs*length);
y1=( r).* exp(-20*t);
plot(y1);
wavplay(y1,44100);
%player = audioplayer(y1,fs)

%end
% fs = 44100; % Hz
% t = 0:1/fs:5; % seconds
% f = 440; % Hz
% y = sin(2.*pi.*f.*t);
% sound(y,fs,16);