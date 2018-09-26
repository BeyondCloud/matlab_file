function f = get_next_f(x,fs,mid,del)
    N = length(x);
    f_x = (f_x(max_i)-del*5:del:f_x(max_i)+del*5)';
    xi = 1;
    XX = zeros(length(f_x),1);
    for j = 1:10
        XX(xi) = sum(x.*exp(-2*pi*i*f_x(j)*(0:N-1)/fs)');
        xi = xi +1;
    end
    XX = abs(XX);
    [~, max_i] = max(XX);
    f = f_x(max_i);
