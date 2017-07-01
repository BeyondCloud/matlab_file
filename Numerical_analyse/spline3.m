%let y = ai+bi*x+ci*x^2+di*x^3
function [a,b,c,d] = spline3(x,y,S1_diff2,SN_diff2)
    %========modify here only=====
%     x = 1:10;
%     y = sin(x);
%     S1_diff2 = 0;
%     SN_diff2 = 0;
    %============================
    N = length(x)-1;

    a(N) =zeros; 
    b(N) =zeros; 
    c(N) =zeros; 
    d(N) =zeros; 

    h(N) = zeros;
    u(N+1) = zeros;
    v(N+1) =zeros; 

    for i=1:N
        h(i) = x(i+1)-x(i);
        b(i) = (y(i+1)-y(i))/(x(i+1)-x(i));
    end
    for i=2:N
        u(i) = 2*(h(i-1)+h(i));
        v(i) = 6*(b(i)-b(i-1));
    end
    tdma_A = [h(1:N-1) 0];
    tdma_B = [1 u(2:N) 1];
    tdma_C = [0 h(2:N)];
    tdma_D = [S1_diff2 v(2:N) SN_diff2] %the first and end value is S1()" Sn()" initial value 
    z = TDMA(tdma_A,tdma_B,tdma_C,tdma_D);
    for i=2:N+1
        C= y(i-1)/(x(i)-x(i-1)) - z(i-1)*(x(i)-x(i-1))/6;
        D = y(i)/(x(i)-x(i-1)) - z(i)*(x(i)-x(i-1))/6;
        delx6 = 6*(x(i)-x(i-1));
        d(i-1) = (-z(i-1)+z(i))/delx6;
        c(i-1) = 3*(z(i-1)*x(i)-z(i)*x(i-1))/delx6;
        b(i-1) = 3*(-z(i-1)*x(i)^2+z(i)*x(i-1)^2)/delx6-C+D;
        a(i-1) = (z(i-1)*x(i)^3-z(i)*x(i-1)^3)/delx6 +C*x(i)-D*x(i-1);
    end
    a = reshape(a,N,1)
    b = reshape(b,N,1)
    c = reshape(c,N,1)
    d = reshape(d,N,1)

    xx = 2:0.25:9.5;
     for i = 1:length(xx)
        yy(i) = a(floor(xx(i)))+xx(i)*b(floor(xx(i)))...
            +(xx(i).^2)*c(floor(xx(i)))+(xx(i).^3)*d(floor(xx(i)))
     end
     plot(xx,yy,'-o');
end