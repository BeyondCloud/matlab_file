% return array of structs p contain elements below: 
%     atk:voice attack point
%     loopA:loop start point
%     loopB:loop end point

function p = oto_param_preprocess(x,fs)
    if nargin <= 1 
        fs = 44100;
        disp('oto_param_preprocess:Use default fs 44100');
    end
    for i = 1:length(x)
        p(i).atk = floor(x(i,1)*fs/1000);
        p(i).loopA = floor((x(i,4) + x(i,1))*fs/1000);
        p(i).loopB = floor((abs(x(i,3)) + x(i,1))*fs/1000);
    end
end