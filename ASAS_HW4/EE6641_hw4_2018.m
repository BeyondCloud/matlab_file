%% EE6641 HW3: sinusoidal modeling, additive synthesis, and noise reduction
% Adapted from a Stanford EE367 lab assignment in 2002.
% Revised Apr 10, 2014
% Revised Feb 21, 2017
% Yi-Wen Liu
clear; close all;
%fname = 'peaches_16';
fname = 'wrenpn'
%fname = 'mymom_16';
%fname = 'draw_16';

maxPeaks = 5; 
control.expandRatio = 2.0;
keyShift = -12; 
control.fRatio = 2^(keyShift/12); 

[x,fs] = audioread([fname '.wav']);
%x = x/max(abs(x)); 
% sound(x,fs);
nx = length(x);

%% ANALYSIS PARAMETERS
frameRate =20;  % frames per second
M = floor(fs/frameRate);  
nFrames = floor(nx/M)*2-1;
R = floor(M/2);  % Exact COLA not required
N = 2^(1+floor(log2(5*M+1))); % FFT length, at least a factor of 5 zero-padding

%% VECTOR VARIABLES DECLARATION
amps = zeros(maxPeaks,nFrames);
freqs = zeros(maxPeaks,nFrames);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANALYSIS
%%
%w = hanning(M);
w = blackman(M);
df = fs/N;
ff = 0:df:(N-1)*df;
x = x(1:(nFrames-1)*R+M);
for m=1:nFrames
    tt = (m-1)*R+1:(m-1)*R+M;
    xw = w .* x(tt);
    Xw = fft(xw,N); % 
    [ampdB,freqindex] = MyFindpeaks(Xw(1:N/2),maxPeaks); % 
    freqsm = (freqindex-1)*pi/(N/2);
    amps(:,m) = ampdB; % amplitude is coded in dB unit
    freqs(:,m) = freqsm;
end

% figure(1)
% plot(freqs');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SYNTHESIS

y = MyAdditivesynth(amps,freqs,R,control);
y = y/max(abs(y)); 
sound(y,fs);

audiowrite(sprintf('%s_SM_%d.wav',fname,maxPeaks),y,fs);

