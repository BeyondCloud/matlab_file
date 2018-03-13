%   EE6641 ASAS Hw1: Spectrogram

clear; close all; clc;
%% setup

opt.useFunc = 0; % use matlab spectrogram function or not
opt.windowType = 'hann'; % rectwin, hann, or hamming etc.

window_length = 0.2; % second, i.e.,20ms.
overlap = 0.2; % Ratio of overlap and window length

%% STFT

if opt.useFunc, use_spectrogram = str2func('spectrogram');
else use_spectrogram = str2func('mySpectrogram'); end

window_gen = str2func( opt.windowType );

% load wav file
[x, fs] = audioread('./test.wav');
% [x, fs] = wavread('./test.wav');
x = x(:,1); % to mono channel

window = window_gen( round(window_length*fs) );
noverlap = round(length(window)*overlap);

nfft = power(2, ceil( log2(length(window)) ));
% nfft = 1024;

% Do STFT
[S,F,T] = use_spectrogram( x, window, noverlap, nfft, fs);

%% Show Spectrogram

surf(T,F,10*log10(abs(S)),'EdgeColor','none');
axis xy; axis tight; view([0,90]);
xlabel('Time (s)');
ylabel('Frequency (Hz)');
