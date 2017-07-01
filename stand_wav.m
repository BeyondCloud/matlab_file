clc;
clear;
t = 0;
j = 0;
z = linspace(-4*pi , 4*pi,1000);
for k=1:256
    fr  = cos(t*pi - z);
    bk = cos(t*pi - z+k*0.1);
    y = 0.2*(fr+bk);
    plot(z,fr,'g',z,bk,'g',z,y,'b');
    %all plot properties should write below plot
    %fix axis x from (xfrom xTo yFrom yTo)
    axis([-4*pi 0 -4 4]);
    %ax = gca;
    %ax.XTick = [-3*pi -2*pi pi 0 pi 2*pi 3*pi];
    grid on;
    set(gca,'XTick',-3*pi:pi:3*pi);
    pause(0.1);
    t=t+2*0.0078125;
end