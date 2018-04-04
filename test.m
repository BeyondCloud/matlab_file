[x fs] = audioread('my_a2.wav');
x = x(1:fs*4);

N = 1024;
frames = floor(length(X)/N);
Xn = zeros(N,frames);
pha =  zeros(N,frames);

for f = 1:frames 
    Xn(:,f) = fft(x((f-1)*N+1:f*N),N);
end
for f = 1:frames 
    pha(:,f) = Xn(:,f)./abs(Xn(:,f));
end
    
y=Xn;
for f = 1:frames
    y(:,f) = ifft(abs(Xn(:,f)).*pha(:,f));
end
y = real(reshape(y,1,[]));
sound(y,fs);