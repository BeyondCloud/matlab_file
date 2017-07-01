clear;
clc
N = 1000000
y = rand( 1, N ,'double')+1;   %from 1~2
z = 4*rand( 1, N ,'double')-1; %from -1~3
x = y.*rand( 1, N ,'double');
Rec_Area = 4*((1+2)*1)/2;
n=0;
for i=1:N
    if(exp(x(i))<=y(i))
        if(sin(z(i))*y(i)>=0)
            n=n+1;
        end 
    end
end
clip_Area = Rec_Area*n/N;
