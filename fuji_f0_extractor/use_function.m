f = get_next_f(x,fs,f_x(max_i),del);
for i = 1:6
    del = del/10;
    f = get_next_f(x,fs,f,del);
end