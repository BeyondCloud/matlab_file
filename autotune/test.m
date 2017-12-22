clc;
clear;
[X, Fs] = audioread('_a_ao.wav'); % Read input from .wav
out = autotune(X, 60, 4200, 64,Fs); % Process signal
audiowrite('out.wav',out, Fs); % Write output to .wav