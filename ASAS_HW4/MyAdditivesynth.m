% Sinusoidal synthesis
% Revised Nov 2010, Yi-Wen Liu
% Revised Feb 2017 for Flipped classroom preparation.
%
% EE6641: Analysis and synthesis of audio signals
% National Tsing Hua University
% This function should take a list of the amplitude, frequency (amplitude in
% dB and frequency in rad/sample) and intial phase of sinusoidal components
% and calculate a frame of the output signal which is the sum of sinusoidal components.
% 
% Synopsis:
% [y]: the output signal
% finalState:   the final state matrix, which will be used as the initial state 
%               for the next frame
%
% amps: the list of amplitudes of the sinusoids (dB)
% freqs: the list of frequencies of the sinusoids (rad/sample)
% N: length of the synthesis frame (samples)
% initState: the initial state matrix

function y = MyAdditivesynth(amps,freqs,hop,control)
nFrames = size(amps,2);
hop = round(hop* control.expandRatio);  % time expansion
freqs = min(pi,freqs*control.fRatio);
y = zeros((nFrames+1)*hop,1);
w=hann(2*hop+1); w=w(1:end-1);
w=w(:);
n = 0:length(w)-1;
    
for m=1:nFrames-1
%     phi = (freqs(:,m)+freqs(:,m+1))/2*R;

    mags = 10.^(amps(:,m)/20); 
    s = mags(:).*cos(freqs(:,m)*n+rand());
    s = sum(s,1);
    s = s(:).*w;
    
    tt = (m-1)*hop+1:(m+1)*hop;  
    y(tt)= y(tt) + s;
end