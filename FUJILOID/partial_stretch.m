%This function will stretch the wav part in given range 
%loop_A~loop_B(unit:sample) to the length result_ms second
% atk:audio start position, samples prior to this will be removed
function y = partial_stretch(x,result_ms,atk,loop_A,loop_B)
    fs = 44100;
    loop_len = loop_B-loop_A+1;
    samps = fs*(result_ms/1000)-(loop_A-atk+1);
    s = samps/loop_len;
    loop = x(loop_A:loop_B);
    y = [x(atk:loop_A);wsolaTSM(loop,s)];
end