clear;
clc;
h=0.1
x = 0:h:1;
y_sol = @(x) 0.2*x*exp(3*x)-(1/25)*exp(3*x)+(1/25)*exp(-2*x)
y =  zeros(length(x),1);
for i=1:length(x)
    y(i)= y_sol(x(i));
end