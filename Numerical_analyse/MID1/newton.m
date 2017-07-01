N = 10;
x = 0.1;
f =@(x) x^2-1;
df =@(x) 2*x;
for i = 1:N
    if(x ==0)
        disp('divide with zero!');
        break;
    end
    x = x - f(x)/df(x);
end