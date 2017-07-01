clear;
%==========change here only===========
f_xy = @(x,y) y+2*x-1
h=0.1;                                             % step size
x = 0:h:1;
y = zeros(length(x),1);
y(1) = 1; %initial condition
k1 = zeros(length(x),1);
k2 = zeros(length(x),1);

%==============================
for i=2:length(x)
    k1(i) = f_xy(x(i-1),y(i-1));
    k2(i) = f_xy(x(i-1)+(3/4)*h,y(i-1)+(3/4)*h*k1(i));
    y(i)  = y(i-1)+h*((1/3)*k1(i) +(2/3)*k2(i));
end

disp('Ralston')