function y = my_hamming(n)
    y = 0.54-0.46*cos(2*pi*(0:(n-1))/(n-1))';
end