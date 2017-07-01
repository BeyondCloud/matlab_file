N = 1000
rndx = rand( 1, N ,'double')
rndy = rand( 1, N ,'double')
n=0;
for i=1:N
    if((rndx(i)^2+rndy(i)^2)<1)
        n=n+1;
    end
end
my_pi = 4*n/N;
