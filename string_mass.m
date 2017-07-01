clear;
srate = 8000;
m=0.001;
k=1000;
r=0.002;
oversamp = 50;
T=1/(srate*oversamp);
tmp = m+(T*r)+(T^2*k);
coeff1 = (2*m+T*r)/tmp;
coeff2 = -m/tmp;
y = [0 1 0];
for i = 0:(2000)
    t=i/srate;
    ideal(i+1) = exp(-t)*cos(1000*t);
    for j =0:(oversamp-1)
        y(1)=y(2)*coeff1+y(3)*coeff2;
        y(3)=y(2);
        y(2)=y(1);
    end
    appr(i+1) = y(2)-y(3);
end
subplot(2,1,1);
plot(ideal);
subplot(2,1,2);
plot(appr);
