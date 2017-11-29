function d = stft(x, f, w, h)
%
% function to calculate short-time Fourier transform of a signal; signal is
% blocked into frames (windows) of size w samples; window is weighted by 
% a hann window of size w samples; window is shifted by h samples; process
% is iterated until window exceeds length of signal
%
% Inputs:
%   x: input signal
%   f: FFT size in samples (usually same as window size)
%   w: window size in samples
%   h: window shift in samples
%
% Output:
%   d: matrix of short-time Fourier transforms

% make the frame hop size, hop, an integer
    hop=round(h);
    
% calculate number of samples in x
    s = length(x);

% force window to be odd-length since even length hann window has zeros at
% the endpoints
    if rem(w, 2) == 0   
        w = w + 1;
    end

% define hann window as symmetric half cosine
    halflen = (w-1)/2;
    halff = f/2;   % midpoint of win
    acthalflen = min(halff, halflen);
    halfwin = 0.5 * ( 1 + cos( pi * (0:halflen)/halflen));
    win = zeros(1, f);
    win((halff+1):(halff+acthalflen)) = halfwin(1:acthalflen);
    win((halff+1):-1:(halff-acthalflen+2)) = halfwin(1:acthalflen);
    
% plot hanning window
    % h1=figure;orient landscape;
    % set(h1,'Position',[80, 78, 990,660]);
    % plot(0:length(win)-1,win,'r','LineWidth',2);
    % axis tight, xlabel('time in samples'),ylabel('value');
    
% initialize count of number of frames within signal
    c = 1;

% pre-allocate output array
    d = zeros((1+f/2),1+fix((s-f)/hop));

% perform STFT calculation using FFTs; store results in
% d(1+f/2,fix((sif)/h)
    for b = 0:hop:(s-f)
        u = win.*x((b+1):(b+f));
        t = fft(u);
        d(:,c) = t(1:(1+f/2))';
        c = c+1;
    end;
    
    fprintf('size of d:%d, %d \n',size(d));
end
