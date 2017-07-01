%let y = ai*+bi*x+ci*x^2

function [a,b,c] = spline2(x,y,S_diff2,whichS)
    % The unknowns are 3*N with a0=0 "Linear Spline"
    % Change initial condition here:
    %Z(1,modify here only) = 1
    %a0=0  -> 1  last=0 -> 3*N-2
    %=========modify here only============
    %important!!!!!!
%     x   =   [1 2 3 4 5];
%     y   =   [4 17 56 207 500];
%     S_diff2  = 0;       %S" value = 2*ai
%     whichS = 1;          %1 or N
    %=====================================
    N   =   length(x)-1;
    V   =  zeros(3*N,1);
    Z   =   zeros(length(V),length( V));
    V(1) = S_diff2/2;
    Z(1,3*whichS-2)=1; %  Z(1,modify here only) = 1

    j=1;
    f=1;
    for i=2:2:2*N    
        Z(i,f:f+2)          =   [x(j)^2 x(j) 1];
        V(i)                =   y(j);
        j                   =   j+1;
        Z(i+1,f:f+2)        =   [x(j)^2 x(j) 1];  
        V(i+1)              =   y(j);
        f                   =   f+3;
    end
    % Filling Matrix from smoothing condition
    j=1;
    k=2;
    for i=2*N+2:3*N

        Z(i,j:j+1)            =   [2*x(k) 1];
        Z(i,j+3:j+4)          =   [-2*x(k) -1];
        j                     =   j+3;
        k                    =   k+1;
    end

    % Inverting and obtaining the coeffiecients, Plotting
    %Z*Coeff = V


    Coeff       =       Z\V;

    %======plot=====
    hold on;
    j=1;
    for i=1:N
        curve=@(l) Coeff(j)*l.^2+Coeff(j+1)*l+Coeff(j+2);
        ezplot(curve,[x(i),x(i+1)]);
        hndl=get(gca,'Children');
        set(hndl,'LineWidth',2);
        hold on
        j=j+3;
    end
        hold off;
    scatter(x,y,50,'r','filled')
    grid on;
    xlim([min(x)-2 max(x)+2]);
    ylim([min(y)-2 max(y)+2]);
    xlabel('x');
    ylabel('y');
    title('Quadratic Spline')

    split_coeff = reshape(Coeff,[3,N]);
    split_coeff = flipud(split_coeff)
    a(N,1)=zeros;
    b(N,1)=zeros;
    c(N,1)=zeros;
    for i = 1:N
        a(i,1) = split_coeff(1,i);
        b(i,1) = split_coeff(2,i);
        c(i,1) = split_coeff(3,i);    
    end

end














