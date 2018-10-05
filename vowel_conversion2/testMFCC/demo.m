fs = 16000;               % sampling frequency (Hz)
nfft = 2^12;              % fft size (number of frequency bins)
K = nfft/2+1;             % length of each filter
M = 23;                   % number of filters

hz2mel = @(hz)(1127*log(1+hz/700)); % Hertz to mel warping function
mel2hz = @(mel)(700*exp(mel/1127)-700); % mel to Hertz warping function

% Design mel filterbank of M filters each K coefficients long,
% filters are uniformly spaced on the mel scale between 300 and 6000 Hz
[ H2, freq c] = trifbank( M, K, [300 6000], fs, hz2mel, mel2hz );


hfig = figure('Position', [25 100 800 600], 'PaperPositionMode', ...
                 'auto', 'Visible', 'on', 'color', 'w'); hold on; 

plot( freq, H2 );
xlabel( 'Frequency (Hz)' ); ylabel( 'Weight' ); set( gca, 'box', 'off' ); 

