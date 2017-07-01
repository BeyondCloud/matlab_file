clear;
clc;
%y = ((b-a)*x+b+a)/2   dy=(b-a)dx/2 
%===========================
order = 4;
b=0.35;
a=0;
f_org = @(x) 2/(x^2-4);
%===========================

Y = @(x) ((b-a)*x+b+a)/2;
dY = (b-a)/2;
f =@(x) f_org(Y(x))*dY;

%f = @(x) 2/(((0.35*x)/2)^2-4)*0.35/2;
gauss_Ans =0;
if order == 1
    gauss_Ans = 2*f(0); 
elseif order == 2
    gauss_Ans = f(sqrt(1/3))+f(-sqrt(1/3)); 
elseif order == 3
    gauss_Ans = (5/9)*f(sqrt(3/5))+(8/9)*f(0)+(5/9)*f(-sqrt(3/5)); 
elseif order == 4
    gauss_Ans = (18+sqrt(30))/36*f(sqrt(3/7-(2/7)*sqrt(6/5)))+...
                (18+sqrt(30))/36*f(-sqrt(3/7-(2/7)*sqrt(6/5)))+...
                (18-sqrt(30))/36*f(sqrt(3/7+(2/7)*sqrt(6/5)))+...
                (18-sqrt(30))/36*f(-sqrt(3/7+(2/7)*sqrt(6/5)));
end
disp('Order:');
disp(order);
disp('Gauss approx:');
disp(gauss_Ans);
