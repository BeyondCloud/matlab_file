%y' = y+2x-1
clear;
%==========change here only===========
f_xy  = @(x,y) y+2*x-1
%warning!!! y(x) should use chain rule
h = 0.1;
x = 0:h:1;
y = zeros(length(x),1);
y(1) = 1; %initial condition
k1 = zeros(length(x),1);
k2 = zeros(length(x),1);

%==============================

 for i=2:length(x)
        k1(i) = f_xy(x(i-1),y(i-1));
        k2(i) = f_xy(x(i-1)+0.5*h,y(i-1)+0.5*h*k1(i));
        y(i) = y(i-1)+h*k2(i);
 end
disp('modi eular')