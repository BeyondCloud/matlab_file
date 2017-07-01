clc;
clear;
x = 0:10; 
y = sin(x); 
xi = 8.8; 
yi = interp1(x,y,xi,'cubic'); 
plot(x,y,'o',xi,yi,'*')
