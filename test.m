t = 0:1/100:10-1/100;                     % Time vector
x = pi/2+sin(pi*30*t)./(30*t*pi);      % Signal
x(1) = pi/2+1
% x = sin(pi*t*30);

y = fft(x);                               % Compute DFT of x
m = abs(y);                               % Magnitude
p = unwrap(angle(y));                     % Phase


f = (0:length(y)-1)*100/length(y);        % Frequency vector

subplot(2,1,1)
plot(f,m)
title('Magnitude')
ax = gca;
ax.XTick = [15 40 60 85];

subplot(2,1,2)
plot(f,p*180/pi)
title('Phase')
ax = gca;
ax.XTick = [15 40 60 85];