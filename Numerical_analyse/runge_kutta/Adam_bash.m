
%y' = y+2x-1
clear
%==========change here only===========
alpha = [1 0 0 0 0;...
         3/2 -1/2 0 0 0;...
         23/12 -16/12 5/12 0 0;...
         55/24 -59/24 37/24 -9/24 0;...
         1901/720 -2774/720 2616/720 -1274/720 251/720];
order = 3;
y_dif = @(x,y) y+2*x-1
y_sol = @(x)2*exp(x)-2*x-1
h = 0.1;
x = 0:h:1;
y = zeros(length(x),1);
for i=1:order
    y(i) = y_sol((i-1)*h)
end
for i=order+1:length(x)
        sum = 0;
        for j=1:order
            sum = sum+ h*alpha(order,j)*y_dif(x(i-j),y(i-j));
        end
        y(i) = y(i-1)+sum;
end
y;

