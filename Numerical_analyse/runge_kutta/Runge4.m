clc;                                               % Clears the screen
clear all;

h=0.1;                                             % step size
x = 0:h:1;                                         % Calculates upto y(3)
y = zeros(1,length(x)); 
y(1) = 1;                                          % initial condition
f_xy =  @(x,y) y+2*x-1;                    % change the function as you desire
%============================
k1 = zeros(length(x),1);
k2 = zeros(length(x),1);
k3 = zeros(length(x),1);
k4 = zeros(length(x),1);

for i=1:(length(x)-1)                              % calculation loop
    k1(i) = f_xy(x(i)       ,y(i));
    k2(i) = f_xy(x(i)+0.5*h ,y(i)+0.5*h*k1(i));
    k3(i) = f_xy(x(i)+0.5*h ,y(i)+0.5*h*k2(i));
    k4(i) = f_xy(x(i)+h     ,y(i)+k3(i)*h);
    y(i+1) = y(i) + (1/6)*h*(k1(i)+2*k2(i)+2*k3(i)+k4(i));  % main equation
end
y = transpose(y)
disp('Runge4')