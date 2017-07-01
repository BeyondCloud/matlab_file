dim = 4;
A = [6 -2 2 4;12 -8 6 10;3 -13 9 3;-6 3 1 18];
B = [16;26;-19;34];
x(dim) = 0;
if(size(A,1) ~= dim)
    error('array dim error');
end
for n = 1:10   %iterate time
    for i=1:dim
        ax = 0;
        for j=1:dim
            if(j ~= i)
                ax = ax+A(i,j)*x(j);
            end
        end
        x(i) = (B(i)-ax)/A(i,i);
    end
end