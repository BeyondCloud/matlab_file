dense = 10;
tick = 1/dense;
XX = zeros(dense,1);
n = 0:N-1;
f_norm = f_x(max_i)-tick*5:tick:f_x(max_i)+tick*4;
f_norm = f_norm';
xi = 1;
for j = 1:dense
    XX(xi) = sum(x.*exp(-2*pi*i*f_norm(j)*n/N));
    xi = xi +1;
end
XX = abs(XX);
[~, max_i] = max(XX);
disp(f_norm(max_i));


