function c = pvsample(b, t, hop)
%
% function to interpolate an STFT array according to the 'phase vocoder',
% i.e., depending on the rate parameter (speedup or slowdown) as embodied
% in the values of t
%
% Inputs:
%   b: matrix of STFT of input signal (rate=1)
%   t: new set of sampling times according to new rate (rate=r)
%   hop: window shift of original STFT; defaults to half the window length
%
% Output:
%   c: interpolated STFT array based on rate r
%
% For each value of t, the spectral magnitudes in the columns of b are 
% interpolated, and the phase difference between the successive columns 
% of b is calculated; a new column is created in the output array c that 
% preserves this per-step phase advance in each bin.
%
% hop is needed to calculate the 'null' phase advance expected in each bin.
%
% Note: t is defined relative to a zero origin, so 0.1 is 90% of 
% the first column of b, plus 10% of the second.

% check for 3 input arguments; if not set hop to 0 (to be fixed later)
    if nargin < 3
        hop = 0;
    end

% determine the number of rows (frequency values) and columns (time window)
% within the signal duration
    [rows,cols] = size(b);

% calculate FFT/window size, N based on there being N/2+1 frequencies in
% STFT
    N = 2*(rows-1);

% if hop not specified on input, set it to N/2 as default frame shift
    if hop == 0
        hop = N/2;
    end

% pre-allocate memory for output array of interpolated STFTs
    c = zeros(rows, length(t));

% Expected phase advance in each bin; differential phase due to a window
% shift of hop samples
    % dphi = zeros(1,N/2+1);
    % dphi(2:(1 + N/2)) = (2*pi*hop)./(N./(1:(N/2)));

% Phase accumulator
% Preset to phase of first frame for perfect reconstruction
% in case of 1:1 time scaling
    ph = angle(b(:,1));

% Append a 'safety' column on to the end of b to avoid problems 
% taking *exactly* the last frame (i.e. 1*b(:,cols)+0*b(:,cols+1))
    b = [b,zeros(rows,1)];

% begin accumulating output STFT by interpolating phase and magnitude of
% STFT at the new rate
    ocol = 1;
    
% use array t to provide interpolated time scale
    for tt = t
        
% Grab the two columns of b (one before t, one after t);
% Interpolate magnitude from the two columns at all frequencies
        bcols = b(:,floor(tt)+[1 2]);
        tf = tt - floor(tt);
        bmag = (1-tf)*abs(bcols(:,1)) + tf*(abs(bcols(:,2)));
        
% debug printout
        if (ocol <= 5)
            fprintf('tt:%6.2f, ocol:%d, cols: %d %d, tf:%8.2f \n',tt,ocol,floor(tt)+[1,2],tf);
        end
        
% calculate phase advance
        % dp = angle(bcols(:,2)) - angle(bcols(:,1)) - dphi';
        dp = angle(bcols(:,2)) - angle(bcols(:,1));
        
% Reduce to -pi:pi range
        % dp = dp - 2 * pi * round(dp/(2*pi));
        
% Save the column
        c(:,ocol) = bmag .* exp(j*ph);
        
% Cumulate phase, ready for next frame
        % ph = ph + dphi' + dp;
        ph = ph + dp;
        ocol = ocol+1;
end
