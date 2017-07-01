clear;
%==========change here only===========
f_xy  = @(x,y) x*exp(3*x)-2*y;
h = 0.1;
x = 0:h:1;
y = zeros(length(x),1);
y(1) = 0; %initial condition
k1 = zeros(length(x),1);
k2 = zeros(length(x),1);

%==============================

 for i=2:length(x)
        k1(i) = f_xy(x(i-1),y(i-1));
        k2(i) = f_xy(x(i-1)+0.5*h,y(i-1)+0.5*h*k1(i));
        y(i) = y(i-1)+h*k2(i);
 end
disp('modi eular')