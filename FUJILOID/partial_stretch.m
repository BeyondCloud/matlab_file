%This function will stretch the wav part in given range 
%loop_A~loop_B(unit:sample) to the length result_ms second
% atk:audio start position, samples prior to this will be removed
function y = partial_stretch(x,result_ms,p)

    if iscell(result_ms)
        result_ms = str2num(result_ms{1});
    end
    if p.loopA>p.loopB
        error('p.loopA>p.loopB');
    end

    fs = 44100;
    loop_len = p.loopB-p.loopA+1;
    samps = fs*(result_ms/1000)-(p.loopA-p.atk+1);
    s = samps/loop_len;
    loop = x(p.loopA:p.loopB);
    
    y = [x(p.atk:p.loopA);wsolaTSM(loop,s)];
end