function x = fix_f0(x)
    k_stable = 20;
    thres = 5;
    stable_cnt = 0;
    prev_stable_end = 1;
    for i = 2:length(x)
        if abs(x(i)-x(i-1))<thres
            stable_cnt=stable_cnt+1;
        else
            stable_cnt = 0;
        end
        if stable_cnt>=k_stable
            %fix spike
            edge = [prev_stable_end i];
            unstable = prev_stable_end+1:i-1;
            x(unstable)=interp1(edge,x(edge),unstable);
            
            while abs(x(i)-x(i-1))<thres
                i=i+1;
                if(i>length(x))
                    break;
                end
            end
            prev_stable_end = i-1;
            stable_cnt = 0;
        end
    end
    x(prev_stable_end:end) = x(prev_stable_end);
end