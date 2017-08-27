% u = [1 0 1];
% v = [2 7];
% w = conv(u,u);
% yy = xcorr(y);
function final_f = CorrFreq(y_in,Fs)
    if(size(y_in,2)>size(y_in,1))
        y_in = y_in';
    end
    y_len= size(y_in,1);
    %note that 0 lag corr isn't computed
    yy = acf(y_in,y_len-1);
    
    %ignore freq<low_freq to speed up
    low_freq = 20;
    len = floor(y_len/low_freq)

    
%     [out,idx] = sort(yy(1:len),'descend');
   [out,idx]=max(yy);
    
    epslon = 5;
    i = 1;
    while idx(i)<epslon
        i=i+1;
    end
    %update current max
    period_cnt =1;
    df = idx(i)
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
    next_peak = next_peak-df;
    
    final_f = Fs/(next_peak/period_cnt);
    fprintf('freq=%f\n',final_f);
end


