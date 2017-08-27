function x = FFT(x,pnt)
    function y= FFT_r(y,pnt)
        if pnt>1
            k=[0:pnt-1];
            w=exp(-2j*pi.*k/pnt);
            h=y(1:2:end);
            g=y(2:2:end);
            H=FFT(h,pnt/2);
            G=FFT(g,pnt/2);
            y=[H,H]+w.*[G,G];
        end
    end
    x = FFT_r(x,pnt);
    if pnt==256
        x = abs(x(1:pnt/2));
        plot(x);
        x=find(x==max(x));
    end
end