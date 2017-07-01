function p = bisec(f,a,b)
if f(a)*f(b)>0 
    disp('Expect f(a)*f(b)<0')
else
    p = (a + b)/2;
    err = abs(f(p));
    while err > 1e-7
       if f(a)*f(p)<0 
           b = p;
       else
           a = p;          
       end
        p = (a + b)/2; 
       err = abs(f(p));
    end
end

%Note
%Single     1 8  23
%Double     1 11 52
%LongDouble 1 15 64
%EX: 16 17 single.....n>=20 (10000,10001 remain 4,23-4+1)