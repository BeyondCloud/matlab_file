clear;
clc;
w = 2 * rand( 1, 9 ,'double')- 1;
data_in = transpose([0 0;0 1;1 0;1 1]);
Tar = [0;0;0;1];
Out = zeros;
dE_Onet=zeros;
dE_Hnet(3)=zeros;
Onet =zeros;
Learn_Rate = 4.0;

for N = 1:10000
    for i = 1:4
        %forward pp
        I = data_in(:,i);
        W1 = transpose(reshape(w(1:6),2,3));
        hnet = W1*I;  
        Oh  = sigmf(hnet,[1 0]); % 3*1  matrix
        Onet = w(7:9)*Oh; %a constant
        Out = sigmf(Onet,[1 0]); %a constant
        %backward pp
        dE_Onet = (Out-Tar(i))*Out*(1-Out);
        w(7) = w(7) - dE_Onet*Oh(1)*Learn_Rate;
        w(8) = w(8) - dE_Onet*Oh(2)*Learn_Rate;
        w(9) = w(9) - dE_Onet*Oh(3)*Learn_Rate;
        
        dE_Hnet(1) = (w(7)*dE_Onet)*Oh(1)*(1-Oh(1));
        w(1) = w(1) - dE_Hnet(1)*I(1)*Learn_Rate;
        w(2) = w(2) - dE_Hnet(1)*I(2)*Learn_Rate;
        
        dE_Hnet(2) = (w(8)*dE_Onet)*Oh(2)*(1-Oh(2));
        w(3) = w(3) - dE_Hnet(2)*I(1)*Learn_Rate;
        w(4) = w(4) - dE_Hnet(2)*I(2)*Learn_Rate;
        
        dE_Hnet(3) = (w(9)*dE_Onet)*Oh(2)*(1-Oh(2));
        w(5) = w(5) - dE_Hnet(3)*I(1)*Learn_Rate;
        w(6) = w(6) - dE_Hnet(3)*I(2)*Learn_Rate;
    end
end

W1 = transpose(reshape(w(1:6),2,3));
for i = 1:4
    I = data_in(:,i);
    hnet = W1*I;  
    Oh  = sigmf(hnet,[1 0]); % 2*1  matrix
    Onet = w(7:9)*Oh; %a constant
    Out = sigmf(Onet,[1 0]); %a constant
    disp(Out);    
end