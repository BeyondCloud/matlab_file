clear;
clc;
%w = 2 * rand( 1, 8 ,'double')- 1;
w = [0.15 0.2 0.25 0.3 0.4 0.45 0.5 0.55]
data_in = transpose([0.05 0.1;0 1;1 0;1 1]);
Tar = [0.01;0.99]
Out(2) = zeros;
dE_Onet(2)=zeros;
dE_Hnet(2)=zeros;
Onet(2) =zeros;
Learn_Rate = 0.5
for N = 1:10000
    for i = 1:1
        I = data_in(:,i)
        W1 = transpose(reshape(w(1:4),2,2))
        hnet = W1*I+0.35;  
        Oh  = sigmf(hnet,[1 0]); % 2*1  matrix
        Onet(1) = w(5:6)*Oh + 0.6; %a constant
        Out(1) = sigmf(Onet(1),[1 0]); %a constant
        Onet(2) = w(7:8)*Oh + 0.6; %a constant
        Out(2) = sigmf(Onet(2),[1 0]); %a constant
        
        dE_Onet(1) = (Out(1)-Tar(1))*Out(1)*(1-Out(1));
        dE_Onet(2) = (Out(2)-Tar(2))*Out(2)*(1-Out(2));
        w(5) = w(5) - dE_Onet(1)*Oh(1)*Learn_Rate;
        w(6) = w(6) - dE_Onet(1)*Oh(2)*Learn_Rate;
        w(7) = w(7) - dE_Onet(2)*Oh(1)*Learn_Rate;
        w(8) = w(8) - dE_Onet(2)*Oh(2)*Learn_Rate;
        dE_Hnet(1) = (w(5)*dE_Onet(1)+w(7)*dE_Onet(2))*Oh(1)*(1-Oh(1));
        w(1) = w(1) - dE_Hnet(1)*I(1)*Learn_Rate;
        w(2) = w(2) - dE_Hnet(1)*I(2)*Learn_Rate;
        dE_Hnet(1) = (w(6)*dE_Onet(1)+w(8)*dE_Onet(2))*Oh(2)*(1-Oh(2));
        w(3) = w(3) - dE_Hnet(1)*I(1)*Learn_Rate;
        w(4) = w(4) - dE_Hnet(1)*I(2)*Learn_Rate;
    end
end

W1 = transpose(reshape(w(1:4),2,2));
for i = 1:1
    I = data_in(:,i);
    hnet = W1*I+0.35;  
    Oh  = sigmf(hnet,[1 0]); % 2*1  matrix
    Onet = w(5:6)*Oh+0.6; %a constant
    Out = sigmf(Onet,[1 0]); %a constant
    disp(Out);
    Onet = w(7:8)*Oh+0.6; %a constant
    Out = sigmf(Onet,[1 0]); %a constant
    disp(Out);
    
end
