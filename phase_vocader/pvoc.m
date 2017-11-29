function y = pvoc(x, r, n)
%
% function to time-scale a signal to r times faster using phase vocoder
% Step 1: calculate the STFT of signal with 75% overlapped frames
% Step 2: decrease or increase the rate by a factor of r
% Step 3: take the inverse STFT to recover the speeded up or slowed down
% signal
%
% Inputs:
%   x: input waveform
%   r: rate of speedup (1<=r<=4) or slowdown (0.25<=r<=1)
%   n: size of FFT for transforms (default of 1024)
%
% Output:
%   y: speeded up or slowed down waveform

% check for 3 arguments; otherwise set n to 1024 for all FFTs
    if nargin < 3
        n = 1024;
    end

% Using frames of length n samples and a hann window, and with a frame
% shift of hop=n/4 (75% frame overlap) compute STFT
% Also use hann window on output frames for smooth reconstruction
    hop = n/4;
    
% Effect of hanns at both ends is a cumulated cos^2 window (for
% r = 1 anyway); need to scale magnitudes by 2/3 for
% identity of the input/output for r=1
    scf = 2/3;

% Calculate the basic STFT, magnitude scaled by factor scf
    X = scf * stft(x', n, n, hop);

% Calculate the new timebase samples
% Have to stay two cols off end because (a) counting from zero, and 
% (b) need col n AND col n+1 to interpolate
    [rows, cols] = size(X);
    t = 0:r:(cols-2);

% Generate the new spectrogram
    X2 = pvsample(X, t, hop);

% Invert to a waveform
    y = istft(X2, n, n, hop)';
end
