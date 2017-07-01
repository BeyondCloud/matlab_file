function [w1, w2] = truthTBL()
    clear;
    clc;
    inputs = [0 0;0 1;1 0;1 1]
    targets = [0 ;0; 0 ;1]
     w1 = 2 * rand( 2, 1 ,'double')- 1;
     w2 = 2 * rand( 2, 1 ,'double')- 1;
    for i = 1:5000
        output = 1 ./ (1 + exp(-(inputs(:,1)* w1 +inputs* w2 )));
        gradient =  output .*(1 - output);
        w1 = w1+ transpose(inputs)*((targets - output).*gradient);
        output = 1 ./ (1 + exp(-(inputs* w1 +inputs* w2 )));
        gradient =  output .*(1 - output);
        w2 = w2+ transpose(inputs)*((targets - output).*gradient);
    end
    testIn([0 0]);
    function testIn(w)
        disp(sigmf((w*w1+w*w2),[1 0]))
    end
end
