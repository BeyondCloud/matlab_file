let h = b-a , c = (b+a)/2
1.對中央c展開求出解析解
(h/2~-h/2) = hf(c) + h^3f(c)''/24 +h^5*f(c)''''/1152 + ...
2.f(c-h/2) ,f(c) ,f(c+h/2)


f(c+x) = f(c) + x*f(c)'+x^2*f(c)''/2!....
int (h/2~-h/2)f(x+c)...exact  = hf(c)+f(c)'+h^2/24f''(c)+h^4/1920+...
(b-a)/6*(f(a)+4f(c)+f(b)) = h/6*(f(c-h/2)+4f(c)+f(c+h/2))
expand f(c+h/2), f(c-h/2)
h/6*(f(c-h/2)+4f(c)+f(c+h/2)) =
Ans  = -5*(h^5)*f(c)''''/2880 + O(h^7)

8/3 method
41/20736-1/1152 
Ans  = 23*f(c)''''/20736 + O(h^7)

