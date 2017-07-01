function fuji_fft(input,Fs)
% Fs = 1000;            % Sampling frequency
% T = 1/Fs;             % Sampling period
% L = 1000;             % Length of signal
% t = (0:L-1)*T;        % Time vector
% S = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
% X = S + 2*randn(size(t));
if(size(input,1) ~= 1 && size(input,2) ~= 1)
    disp('one channel input expected')
    return
end
L = size(input,1)*size(input,2);
Y = fft(input);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;
plot(f,P1)
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
