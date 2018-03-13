% return frq tbl with size of the duration of the note in ms
function y = get_frqtbl(sig_len,t,f,Fs)
    y = zeros(sig_len,1);
    to = 1;
    from =floor(Fs*(t(1)/1000));
    y(1:from) = f(1);
    for i = 2:length(t)
        from =floor(Fs*(t(i-1)/1000));
        to = floor(Fs*(t(i)/1000));
        y(from:to-1) = f(i-1);
    end
    y(to:end) = f(end);
end