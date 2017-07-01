

x = -1:1;
y = [1 2 5];
cs = spline(x,[y]);
xx = linspace(-1,1,101);
plot(x,y,'o',xx,ppval(cs,xx),'-');
hold on;

yy = zeros(1,101);
for i = 1:101
    if(xx(i)<0)
        yy(i) =1+0.5*(xx(i)+1)+0.5*(xx(i)+1)^3
    else
        yy(i) =2+2*xx(i)+1.5*xx(i)^2-0.5*xx(i)^3
        
    end
end
    plot(xx,yy);
hold off;
