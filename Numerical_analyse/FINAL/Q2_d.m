clear;
clear
%change this parameter to 3,4,5 to view answer ^_^
order = 3;

alpha = [1 0 0 0 0;...
         1/2 1/2 0 0 0;...
         5/12 8/12 -1/12 0 0;...
         9/24 19/24 -5/24 1/24 0;
         251/720 646/720 -264/720 106/720 -19/720];
%==========change here only===========
y_dif = @(x,y)x*exp(3*x)-2*y;
y_sol = @(x) 0.2*x*exp(3*x)-(1/25)*exp(3*x)+(1/25)*exp(-2*x)
h = 0.1;
x = 0:h:1;
y = zeros(length(x),1);
for i=1:order-1
    y(i) = y_sol((i-1)*h)
end
%=======================================
for t = 1:10
    for i=order:length(x)
        sum = 0;
        for j=1:order
            sum = sum+ h*alpha(order,j)*y_dif(x(i+1-j),y(i+1-j));
        end
        y(i) = y(i-1)+sum;
    end
end
clc
disp('y=');
disp(y);
disp('Adam Mon');
