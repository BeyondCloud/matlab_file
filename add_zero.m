% b = fir1(48,[0.35 0.65]);
[x,fs] = audioread('ya.wav');
% xx =  conv(b,x);
win = 100;
i = 1;
dz = 50;
cur = 1;
while cur+win-1 < length(x)
    x(cur:cur+win-1) = x(i:i+win-1);
    cur = cur+win;
    x(cur:cur+dz-1) = zeros(dz,1);
    cur = cur+dz;
end


