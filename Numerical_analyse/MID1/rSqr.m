function r = rSqr(x,y)
%     f = @(x) 2.1122*x.^(-1)+5.3199 ;
    f = @(x) 2.4786+2.3593*x.^(1)+1.8607*x.^(2) ;
    
    SS_reg   = sum((f(x) -mean(y)).^2 ); 
    SS_total = sum((y     -mean(y)).^2 );
    r = SS_reg/SS_total;
end