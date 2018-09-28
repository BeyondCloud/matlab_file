function env = extract_env(x,fs)
    nfft = 4096;
    X =  abs(fft(x(1:nfft)));
    X = X(1:nfft/2);
    Xdb = mag2db(X);
   
    w = 3;
    p.sr=fs;
    cur_h = mean(yin_f0(x,p));
    cur_h = round(cur_h/fs*(nfft-1)+1);
    harmonics = [0];

    while cur_h+w<length(Xdb)
        [~,idx] = max(Xdb(cur_h-w:cur_h+w));
        idx = cur_h+(idx-w-1);
        harmonics = [harmonics;idx];
        cur_h = cur_h+harmonics(end)-harmonics(end-1);
    end
    harmonics = harmonics(2:end);
    xx = 1:nfft/2+1;
    e_interp = spline([1;harmonics],[Xdb(1);Xdb(harmonics)]);
    env = ppval(e_interp,xx);

end