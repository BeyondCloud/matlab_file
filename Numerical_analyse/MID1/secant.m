N = 10;     %itierate time
x = 0.1;    %initial point
f =@(x) x^2-1;
df =@(x) 2*x;
%use Newton first time
x_prev = x;
x = x_prev - f(x_prev)/df(x_prev);
for i = 1:N
    xMx = x-x_prev;
    fMf = f(x)-f(x_prev);
    if(xMx== 0 )
        disp('x-x_prev = zero!');
        break;
    elseif(fMf== 0)
        disp('f(x)-f(x_prev) = zero!');        
        break;
    end  
    x_prev = x;
    x = x - f(x)/(fMf/xMx);
end
ans = x;