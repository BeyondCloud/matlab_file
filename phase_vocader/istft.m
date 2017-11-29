function x = istft(d, ftsize, w, h)
%
% function to perform inverse short-time Fourier transform
%
% Performs overlap-add resynthesis from the short-time Fourier transform 
% data in d.  Each column of d is taken as the result of an f-point 
% fft; each successive frame is offset by h samples. Data is 
% hann-windowed at w pts..
%
% Inputs:
%   d: interpolated array of short-time spectra at new rate
%   ftsize: size of FFT for each STFT calculation
%   w: frame size for STFT analysis
%   h: frame/window offset between adjacent frames
%
% Output:
%   x: resulting rate adjusted signal

% make the frame hop size, hop, an integer
    hop=round(h);
    
% determine the number of frequency points and number of time frames of the
% interpolated STFT, d
    s = size(d);

% determine size of rate adjusted output array
    cols = s(2);
    xlen = ftsize + cols * (hop);
    
% pre-allocate memory for rate adjusted signal
    x = zeros(1,xlen);

% force window to be odd-len
    if rem(w, 2) == 0   
        w = w + 1;
    end

% create hann window with appropriate symmetry around mid-point
    win = zeros(1, ftsize);
    halff = ftsize/2;   % midpoint of win
    halflen = (w-1)/2;
    acthalflen = min(halff, halflen);

% create symmetric hann window
    halfwin = 0.5 * ( 1 + cos( pi * (0:halflen)/halflen));
    win((halff+1):(halff+acthalflen)) = halfwin(1:acthalflen);
    win((halff+1):-1:(halff-acthalflen+2)) = halfwin(1:acthalflen);

% calculate rate adjusted signal from inverse STFT, with overlapping hann
% windows on output frames
    for b = 0:hop:(hop*(cols-1))
        ft = d(:,1+b/hop)';
        ft = [ft, conj(ft([((ftsize/2)):-1:2]))];
        px = real(ifft(ft));
        x((b+1):(b+ftsize)) = x((b+1):(b+ftsize))+px.*win;
    end;
end
