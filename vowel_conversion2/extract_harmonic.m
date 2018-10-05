% clear;clc;
[x fs] = audioread('./data/e_tar.wav');
x = sum(x, 2) / size(x, 2);
x = x/max(x);
N = 4096;
X =  abs(fft(x(1:N)));
f=(0:fs/(N-1):fs);
f = f(1:N/2+1);
X = X(1:N/2+1);
Xdb = mag2db(X);
% Xdb = Xdb(1:4096);

w = 3;
p.sr=fs;
cur_h = mean(yin_f0(x,p));
cur_h = round(cur_h/fs*(N-1)+1);
harmonics = [0];

while cur_h+w<length(Xdb)
    [~,idx] = max(Xdb(cur_h-w:cur_h+w));
    idx = cur_h+(idx-w-1);
    harmonics = [harmonics;idx];
    cur_h = cur_h+harmonics(end)-harmonics(end-1);
end
harmonics = harmonics(2:end);
hold on;
% plot(Xdb);
plot(harmonics,Xdb(harmonics),'o');
