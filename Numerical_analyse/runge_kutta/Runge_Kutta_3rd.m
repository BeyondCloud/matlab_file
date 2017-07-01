clear;
%y' = y+2x-1
%==========change here only===========
f_xy = @(x,y) y+x
N=11;   %11 points
L=1;    %length
h = L/(N-1);
x = zeros(N,1);
y = zeros(N,1);
y(1) = 1; %initial condition
k1 = zeros(N,1);
k2 = zeros(N,1);
k3 = zeros(N,1);

for i=1:N
    x(i) = (i-1)*h;
end
%==============================
for t = 1:1
    for i=2:N
        
        k1(i) = f_xy(x(i-1),y(i-1))
        k2(i) = f_xy(x(i-1)+0.5*h,y(i-1)+0.5*h*k1(i));
        
        k3(i) = f_xy(x(i-1)+h,y(i-1)-h*k1(i)+2*h*k2(i));
        
        y(i) = y(i-1)+(1/6)*h*(k1(i)+4*k2(i)+k3(i));
    end
end