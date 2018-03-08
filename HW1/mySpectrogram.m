%   EE6641 ASAS Hw1: Spectrogram

function [S, F, T] = mySpectrogram( x, window, noverlap, nfft, fs)

    if nargin < 3, noverlap = 0; end
    if nargin < 4, nfft = length(window); end
    if nargin < 5, fs = 2*pi; end   % If no fs input, show angular frequency.

    frame_length = length(window);
    frame_shift = frame_length - noverlap;
    
%     Calculating # of frames:
%       x_length = ( frame_length - noverlap) * ( # - 1 ) + frame_length
%       =>  # = ( x_length - frame_length ) / ( frame_length - noverlap ) + 1
    nframe = ceil( ( length(x) - frame_length ) / frame_shift );
    
%     Initializing spectrogram matrix
    S = complex( zeros( nfft, nframe ) );
    
    %%%%%%%%%%%%%%%%%% YOUR CODE BELOW %%%%%%%%%%%%%%%%%%
    start_pos=1;
    for n_sig  = 1:nframe
%         Generating signals frame-by-frame
        sig = x(start_pos:start_pos+frame_length-1);
%         Windowing
        sig = sig.*window;
        
%         Fast Fourier Transform
        S(:,n_sig) = fft(sig,nfft);
        start_pos = start_pos+frame_shift;
    end
    
    %%%%%%%%%%%%%%%%%% YOUR CODE ABOVE %%%%%%%%%%%%%%%%%%
    
    S = S( 1:floor(nfft/2)+1, : );                             % Only preserve half of Spectrum
    
    % Scale of frequency axis
    F = (0:floor(nfft/2))'/floor(nfft/2)*fs/2;       
    
    % Scale of time axis
    if (fs - 2*pi) < 1e-5
        T = 1:nframe;
    else
        T = (frame_length/2:frame_shift:length(x));     
        T = T(1:nframe)/fs;
    end
end

