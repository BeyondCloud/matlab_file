function y = my_hann(n)
    y = 0.5*(1-cos(2*pi*(0:(n-1))/(n-1)))';
end