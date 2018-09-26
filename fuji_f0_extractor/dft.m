clear;clc;
fs = 1000;
t = (1:1000);
f = 20.253;
x = cos(2*pi*f*t/fs);
N = length(x);
n = 1:N;
if f>=fs/2
    error('error:exceed Nyquist rate');
end
XX = zeros(N,1);
dense = 10;
for k = 1/dense:1/dense:N
    XX(floor(k*dense)+1) = sum(x.*exp(-2*pi*i*(k)*n/N));
end
XX = abs(XX(1:floor(length(XX)/2)));
plot((0:length(XX)-1)/dense,XX);
[~,argX] = max(XX);
freq = (argX-1)/dense;