syms y(x)
%Dy = diff(y);
ode = diff(y,x,1) == y-x^2+1;
cond1 = y(0) == 0.5;
%cond2 = Dy(0) == 0;
%conds = [cond1 cond2];

conds = [cond1];
ySol(x) = dsolve(ode,conds);
ySol = simplify(ySol)