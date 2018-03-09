addpath('C:\Users\a1989\OneDrive\¤å¥ó\MATLAB\MATLAB_TSM-Toolbox_2.01')
fs = 44100;
p.atk = 18593;
p.loopA = 27947;
p.loopB = 37883;
[x fs] = audioread('a_ao.wav');
result_ms = 1000
y = partial_stretch(x,result_ms,p);