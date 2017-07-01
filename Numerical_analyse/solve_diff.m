clear;
syms y(x)
Dy = diff(y);
ode = diff(y,x,1) == cos(2*x)+sin(3*x); %diff(y,x,diff order)
cond1 = y(0) ==1;
%cond2 = Dy(0) == 0;

%conds = [cond1 cond2];
conds = [cond1];
ySol(x) = dsolve(ode,conds);
ySol = simplify(ySol)


%syms y(x)
%diff(y(x)+2x-1)>>>return diff(y(x), x) + 2 >>>(y+2x-1)+2
%y_dif2 = @(x,y) y+2*x+1