clear;
%y' = y+2x-1
%==========change here only===========
f_xy = @(x,y) y+2*x-1
L=1;    %length
h=0.1;   
x = 0:h:1;  
y = zeros(length(x),1);
y(1) = 1; %initial condition
%==============================
k1 = zeros(length(x),1);
k2 = zeros(length(x),1);
k3 = zeros(length(x),1);
k4 = zeros(length(x),1);
 for i=1:(length(x)-1)  
        %yn+1 = yn+ (1/2)k1
        k1(i) = h*f_xy(x(i),y(i));
        
        k2(i) = h*f_xy(x(i)+0.5*h,y(i)+0.5*k1(i));
        
        k3(i) = h*f_xy(x(i)+0.5*h,...
            y(i)+0.5*(sqrt(2)-1)*k1(i)+(1-sqrt(2)/2)*k2(i));
        
        k4(i) = h*f_xy(x(i)+h,y(i)-sqrt(2)/2*k2(i)+(1+sqrt(2)/2)*k3(i))
        
        y(i+1) = y(i)+(1/6)*(k1(i)+(2-sqrt(2))*k2(i)+...
                            (2+sqrt(2))*k3(i)+k4(i));
 end
 disp('Gill4')