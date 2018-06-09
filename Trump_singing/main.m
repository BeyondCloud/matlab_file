addpath('C:\Users\a1989\OneDrive\¤å¥ó\MATLAB\MATLAB_TSM-Toolbox_2.01');

ratio = (f0_pit/2^(0/12))./f0_lyc;
% ratio  = ones(size(ratio));
result = modify_pit(x_lyc,ratio,fs);