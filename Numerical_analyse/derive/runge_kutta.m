yi+1 = yi + h*fi + h^2/2*fi'
     = yi + h*fi + h^2/2*(fxi + fyi*fi)
     = yi + h*fi + h^2/2*fxi + h^2/2*fyi*fi

yi+1 = yi + c1*h*k1+c2*h*k2
k1 = f(xi,yi)
k2 = f(xi+p2*h,yi+a21*h*k1);

yi+1 = yi + c1*h*fi+c2*h*(fi + p2*h*fxi + a21*h*fyi*fi);
     = yi + c1*h*fi+c2*fi*h + c2*p2*h^2*fxi + c2*a21*h^2*fyi*fi;

c1+c2=1
c2*p2=1/2
c2*a21=1/2


