N = 60;
y = bartlett(N);
len = 300
hop = 30;
yy =  zeros(len,1);
i = 1;
while i+N < len
    yy(i:i+N-1,1) = yy(i:i+N-1,1)+y;
    i = i+hop;
end
plot(yy);
