function y = oto_param_preprocess(x,fs)
    if nargin <= 1 
        fs = 44100;
        disp('oto_param_preprocess:Use default fs 44100');
    end
    y = zeros(length(x),3);
    y(:,1) = x(:,1);
    y(:,2) = (x(:,2) + x(:,1));
    y(:,3) = (abs(x(:,3)) + x(:,1));
    y = floor(y*fs/1000);
end