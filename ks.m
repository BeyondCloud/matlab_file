clc;
clear;
f = 261;
length = 2
fs=44100;
%f=220;
N=fix(fs/f);

X=zeros(1,length*fs);

%loop filter
%        z^-N               
cx=[zeros(1,N) 1];

%       1 - H(z)z^-N
cy=[1 zeros(1,N-1) -.5 -.5];

Zi = rand(1, max(   max(size(cx)) ,  max(size(cy)) ) -1);

Y=filter(cx,cy,X,Zi);
plot(Y);
sound(Y,44100);
