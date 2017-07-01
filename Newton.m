function r = Newton(x1)
    f =@(x) x^2 - 1;
    df =@(x) 2*x;  
    for i = 0:1:10
        x1  = x1 - f(x1)/df(x1); 
    end
    r = x1;
end