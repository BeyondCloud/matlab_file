function final_f = CorrFreq(y_in,Fs)
    %user input checker
    if(size(y_in,2)>size(y_in,1))
        y_in = y_in';
    end
    y_len= size(y_in,1);
    %note that 0 lag corr isn't computed
    yy = acf(y_in,y_len-1);
    
    %ignore freq<low_freq to speed up
    low_freq = 20;
    len = floor(y_len/low_freq);
    [out,idx] = sort(yy,'descend');
    epslon = 5;
    
    % find the first peak near by lag0 corr
    if idx(1) > epslon
        i = 1;
        df = idx(1)
    else
        i = 2;
        while (idx(i)-idx(i-1))<epslon
            i=i+1;
        end
        df = idx(i)
    end
    period_cnt = 1;
    next_peak = idx(i)+df;
    
    while next_peak<(y_len-1)
        period_cnt=period_cnt+1;
        if y_in(next_peak)<y_in(next_peak+1)
            next_peak=next_peak+1;    
        end
        if y_in(next_peak)<y_in(next_peak-1)
            next_peak=next_peak-1;
        end
        next_peak = next_peak+df;
    end
    next_peak = next_peak-df
    period_cnt
    
    final_f = Fs/(next_peak/period_cnt);
    fprintf('freq=%f\n',final_f);
end


