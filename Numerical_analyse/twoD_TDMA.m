close all;
clear all;
clc

N = 101;
LX = 10;
LY = 10;

dX = 10/(N-1);
dY = 10/(N-1);

T= zeros(N,N);
i=0
while i<1000
    i=i+1;
    T_old =  T;
    % x dir
    for y= 2: N-1
        AX(1) = 0;      %won't use
        BX(1) = 1;     
        CX(1) = 0;
        DX(1) = 0;
        
        AX(N) = 1;
        BX(N) = -1;
        CX(N) = 0;  %won't use
        DX(N) = 0;
        
        for x= 2: N-1
            AX(x) = 1/(dX^2);
            BX(x) = -2*(1/(dX^2)+1/(dY^2));
            CX(x) = 1/(dX^2);
            DX(x) = 1-(T(x,y-1)+T(x,y+1))/(dY^2); %T(x,y-1),T(x,y+1) view as const
        end
        T(:,y) = TDMAsolver(AX,BX,CX,DX);
    end
    
    % y dir
    for x= 2: N-1
        n     = 1;
        AY(1) = 0;
        BY(1) = 1;
        CY(1) = 0;
        DY(1) = 0;
        
        AY(N) = 1;
        BY(N) = -1;
        CY(N) = 0;
        DY(N) = 0;
        for y= 2: N-1
            AY(y) = 1/(dY^2);
            BY(y) = -2*(1/(dX^2)+1/(dY^2));
            CY(y) = 1/(dY^2);
            DY(y) = 1-(T(x-1,y)+T(x+1,y))/(dX^2);
        end
        T(x,:) = TDMAsolver(AY,BY,CY,DY);    
    end
    if abs(max(abs(T(:)))-max(abs(T_old(:))))<0.005
        break
    end
    
end

x1=(([1:N]-1)/(N-1))*LX ;
y1=(([1:N]-1)/(N-1))*LY ;
[X1 Y1]=meshgrid(x1,y1) ;

pcolor(x1,y1,T) ; 
shading interp;
h=colorbar;



