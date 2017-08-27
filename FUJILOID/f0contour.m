% in_str = 'a_ao.wav';
% [in,Fs] = wavread(in_str);
Fs = 6000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector
X = 0.7*cos(2*pi*50*t) ;
Y = 0.7*cos(2*pi*60*t) ;
Z = [X Y];
%acf(Z,2*L-1);
%audiowrite('test.wav',X,44100);
f = CorrFreq(Z,Fs);