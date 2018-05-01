%% EE6641 HW3: sinusoidal modeling, additive synthesis, and noise reduction
% Adapted from a Stanford EE367 lab assignment in 2002.
% Revised Apr 10, 2014
% Revised Feb 21, 2017
% Yi-Wen Liu
clear; close all;
% fname = '602';
% fname = 'wrenpn'
fname = 'mymom_16';
%fname = 'draw_16';

maxPeaks = 30;
control.expandRatio = 1.0;
keyShift = 0; 
control.fRatio = 2^(keyShift/12); 

[x,fs] = audioread([fname '.wav']);

%% ANALYSIS PARAMETERS
frameRate =20;  % frames per second
SPF = floor(fs/frameRate); %SPF:samples per frame  
nFrames = floor(length(x)/SPF)*2-1;
hop = floor(SPF/2); 
nfft = 2^(1+floor(log2(5*SPF+1))); % FFT length, at least a factor of 5 zero-padding

%% VECTOR VARIABLES DECLARATION
amps = zeros(maxPeaks,nFrames);
freqs = zeros(maxPeaks,nFrames);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ANALYSIS
%%
%w = hanning(M);
w = blackman(SPF);
df = fs/nfft;
ff = 0:df:(nfft-1)*df;

%zero padding to fix fft size
x = [x;zeros(ceil(length(x)/nfft),1)];
for m=1:nFrames
    tt = (m-1)*hop+(1:SPF);
    xw = w .* x(tt);
    Xw = fft(xw,nfft); 
    [ampdB,freqindex] = MyFindpeaks(Xw(1:nfft/2),maxPeaks); % 
    freqsm = (freqindex-1)*pi/(nfft/2);
    amps(:,m) = ampdB; % amplitude is coded in dB unit
    freqs(:,m) = freqsm;
end

% figure(1)
% plot(freqs');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SYNTHESIS

y = MyAdditivesynth(amps,freqs,hop,control);
y = y/max(abs(y)); 
sound(y,fs);

audiowrite(sprintf('%s_SM_%d.wav',fname,maxPeaks),y,fs);
