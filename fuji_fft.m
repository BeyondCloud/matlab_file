%function fuji_fft(input,Fs)
Fs = 1000;            % Sampling frequency
T = 1/Fs;             % Sampling period
L = 1000;             % Length of signal
t = (0:L-1)*T;        % Time vector
input = 0.7*sin(2*pi*50*t) + sin(2*pi*120*t);
X = S + 2*randn(size(t));
if(size(input,1) ~= 1 && size(input,2) ~= 1)
    disp('one channel input expected')
    return
end
L = size(input,1)*size(input,2);
Y = fft(input);
P2 = abs(Y/L);
P1 = 2*P2(1:L/2+1);
f = Fs*(0:(L/2))/L;
f2 = Fs*(0:L-1);

plot(f,P1)
plot(f2,P2)

title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
