inc = 100
t = -10:1/inc:10-1/inc;                     % Time vector
x =sin(pi*t/2)./(t*pi);      % Signal
x(1001) = 0.5
N = length(x);
X = zeros(N,1)
for k = 0:N-1
    for n = 0:N-1
        X(k+1) = X(k+1) + x(n+1)*exp(-j*pi/2*n*k);
    end
end


m = abs(X);                               % Magnitude
p = unwrap(angle(X));                     % Phase


f = (0:length(X)-1)*inc/length(X);        % Frequency vector

plot(f,abs(X))
title('Magnitude')