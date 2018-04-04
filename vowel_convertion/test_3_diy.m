fs = 16000 
len  =1 
t = 0:1/fs:2;
f1 = 770;
f2 = 1336;
a = 0.3;
y1 = a*sin(2*pi*f1*t);
y2 = a*sin(2*pi*f2*t);
x = y1+y2;
x = x';
N = 1024;
Nh = N/2;   %overlap
w = hamming(N);
frames = floor(2*length(x-N)/N)-1;
i_Xn = zeros(N,frames);

for f = 1:frames 
    i_block = x((f-1)*Nh+1:(f-1)*Nh+N);
    i_Xn(:,f) = fft(i_block.*w,N);
end
frq_tbl = abs(i_Xn(1:512,:));
hold on;
for i = 1:frames
    findpeaks(frq_tbl(:,1),[fs/1024:fs/1024:fs/2]);
    pause(0.05);
end
