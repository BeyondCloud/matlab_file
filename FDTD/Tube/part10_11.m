clear;clc;close all;

p = 20;
[input,fs] = audioread('utterance.wav');
fn = fs/2;

%create window and constants
win = hamming(.02*fs);
overlap = .5;
frame_length = .02*fs;
win = hamming(frame_length);

%pad the input to be equally divisible by the window length to avoid
%problems later on
while mod(length(input),(frame_length))
    input = [input; 0];
end

time_vector = [1/fs:1/fs:length(input)/fs];
time_vector = time_vector';
figure(1), plot(time_vector,input);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Short Speech Sample');
fig11 = figure(1);


number_of_frames = (length(input)/(frame_length)/overlap) - 1;

first_frame = input(1:length(win));
win_frame = first_frame.*win;
autocorr = xcorr(win_frame);
rn = autocorr(ceil(length(autocorr)/2):length(autocorr));

%%%%%pre-emphasis filter
num=[1 -rn(2)/rn(1)];
den=[1];
first_frame = filter(num,den,win_frame);
pre_e_coeff(1,:) = num;

%A(z) filter
autocorr = xcorr(first_frame);
rn = autocorr(ceil(length(autocorr)/2):length(autocorr));
[alpha error K] = levinson(rn, p);

%gain calculation
alphavalues = alpha(2:length(alpha));
alphavalues = -alphavalues;
summation = 0;
for w = 1:length(alphavalues)
    
    summation = alphavalues(w)*rn(w+1);
        
end

gain = sqrt(rn(1)-summation);

en(1,:) = filter(alpha,gain,first_frame);
coeff(1,:) = alpha;
gaincoeff(1,:) = gain;

for i=2:number_of_frames 
    
    frame=input(((i-1)*frame_length*overlap)+1:((i-1)*frame_length*overlap)+frame_length);
    win_frame = win.*frame;
    autocorr = xcorr(win_frame);
    rn = autocorr(ceil(length(autocorr)/2):length(autocorr));

    %%%%pre-emphasis filter
    num=[1 -rn(2)/rn(1)];
    den=[1];
    frame = filter(num,den,win_frame);
    pre_e_coeff(i,:) = num;

    %A(z) filter
    autocorr = xcorr(frame);
    rn = autocorr(ceil(length(autocorr)/2):length(autocorr));
    [alpha error K] = levinson(rn, p);

    %gain calculation
    alphavalues = alpha(2:length(alpha));
    alphavalues = -alphavalues;
    summation = 0;
    for w = 1:length(alphavalues)

        summation = alphavalues(w)*rn(w+1);

    end

    gain = sqrt(rn(1)-summation);

    %filtering operation
    gaincoeff(i,:) = gain;
    en(i,:) = filter(alpha,gain,frame);
    coeff(i,:) = alpha;

end

%%%%overlap and to get error signal (OAen)

OAen = en(1,:);

for i=2:number_of_frames
    temp = en(i,:);
    OAen(length(OAen)-((frame_length*overlap)-1):length(OAen)) = OAen(length(OAen)-((frame_length*overlap)-1):length(OAen))+ temp(1:length(temp)*overlap);
    temp2 = temp(length(temp)*overlap+1:length(temp));
    OAen = [OAen temp2];

end

%%%%plotting of error signal
figure(12), plot(time_vector, OAen)
fig12 = figure(12);
xlabel('Time (sec)');
ylabel('Amplitude');
title('Error Signal');

final_error_part8 = OAen;

%%%%part%%%%9%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%getting speech back%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%code for first frame stuff because matlab doesn't start indexing at 0
OAen = OAen';
%window the signal
first_frame_inv = OAen(1:length(win)).*win;
%put it through the inverse A(z) filter
num1 = gaincoeff(1,:);
den1 = coeff(1,:);
invfilt = filter(num1,den1,first_frame_inv);
%%%%%DE-emphasis filter
num=[1];
den=pre_e_coeff(1,:);
sn(1,:) = filter(num,den,invfilt);

%%code for the rest of the frames
for i=2:number_of_frames 
    
frame=OAen(((i-1)*frame_length*overlap)+1:((i-1)*frame_length*overlap)+frame_length);
win_frame = win.*frame;
den1 = coeff(i,:);
num1 = gaincoeff(i,:);
invfilt = filter(num1,den1,win_frame);

%%%%DE-emphasis filter

num=[1];
den=pre_e_coeff(i,:);
sn(i,:) = filter(num,den,invfilt);

end

OAsn = sn(1,:);

for i=2:number_of_frames
    temp = sn(i,:);
    OAsn(length(OAsn)-((frame_length*overlap)-1):length(OAsn)) = OAsn(length(OAsn)-((frame_length*overlap)-1):length(OAsn))+ temp(1:length(temp)*overlap);
    temp2 = temp(length(temp)*overlap+1:length(temp));
    OAsn = [OAsn temp2];

end

OAsn = OAsn';
OAsn = OAsn/max(abs(OAsn));
figure(2),plot(OAsn,'-r'), hold on, plot(input)
xlabel('Time (sec)');
ylabel('Amplitude');
title('Reconstructed Speech');
fig2 = figure(2);
legend('Reconstructed Speech', 'Original Speech');

audiowrite('reconstructed_speech.wav',OAsn, fs);

finalSnpart9 = OAsn;




%%%%%%%%%%%%%%%%%%%%PART 10%%%%%%%%%%%%%%%%%%%%%%
%%%reusing a lot of old code%%%%%%%%%%%%%%%%%%%%%

% clear;close all;
% 
% [OAen fs] = wavread('errorsignal.wav');
% frame_length = .02*fs;
% 
% while mod(length(OAen),(frame_length))
%     OAen = [OAen; 0];
% end
% 
% number_of_frames = length(OAen)/frame_length;

%%%%code for first frame stuff because matlab doesn't start indexing at 0
first_frame_inv = OAen(1:frame_length);

%frame processing

if max(first_frame_inv) >.004
  
for x=1:length(first_frame_inv)
   
   if first_frame_inv(x)<=.005
      
       first_frame_inv(x) = 0;
       
   end

   if first_frame_inv(x)>.005
      
       first_frame_inv(x) = 1;
       
   end

end
    
sn(1,:) = first_frame_inv; 

end

if max(first_frame_inv)<=.001
    
    %sn(1,:) = first_frame_inv; 
     new_en(1:frame_length) = first_frame_inv;
    
end

number_of_frames2 = length(OAen)/length(win);
%%code for the rest of the frames
for i=2:number_of_frames2 
    
frame=OAen(((i-1)*frame_length)+1:((i-1)*frame_length)+frame_length);
win_frame = frame;

%frame processing

if max(win_frame) >.12
  
    for x=1:length(win_frame)
   
        if win_frame(x)<=.2
      
            win_frame(x) = 0;
       
        end

        if win_frame(x)>.2
      
            win_frame(x) = 1;
       
        end

    end
    
%     sn(i,:) = win_frame; 
 new_en(((i-1)*frame_length)+1:((i-1)*frame_length)+frame_length) = win_frame;

end

if max(win_frame)<=.12
    
    %sn(i,:) = win_frame; 
    new_en(((i-1)*frame_length)+1:((i-1)*frame_length)+frame_length) = win_frame;
end


end

%%%code to get speech back with new, 'crude' error signal

%%%%code for first frame stuff because matlab doesn't start indexing at 0
OAen = new_en';
%window the signal
first_frame_inv = OAen(1:length(win)).*win;
%put it through the inverse A(z) filter
num1 = [1];
den1 = coeff(1,:);
invfilt = filter(num1,den1,first_frame_inv);
%%%%%DE-emphasis filter
num=[1];
den=pre_e_coeff(1,:);
sn(1,:) = filter(num,den,invfilt);

%%code for the rest of the frames
for i=2:number_of_frames 
    
frame=OAen(((i-1)*frame_length*overlap)+1:((i-1)*frame_length*overlap)+frame_length);
win_frame = win.*frame;
den1 = coeff(i,:);
invfilt = filter([1],den1,win_frame);

%%%%DE-emphasis filter

num=[1];
den=pre_e_coeff(i,:);
sn(i,:) = filter(num,den,invfilt);

end

OAsn = sn(1,:);

for i=2:number_of_frames
temp = sn(i,:);
OAsn(length(OAsn)-((frame_length*overlap)-1):length(OAsn)) = OAsn(length(OAsn)-((frame_length*overlap)-1):length(OAsn))+ temp(1:length(temp)*overlap);
temp2 = temp(length(temp)*overlap+1:length(temp));
OAsn = [OAsn temp2];

end

OAsn = OAsn';
OAsn = OAsn/max(OAsn);
figure(3),plot(OAsn,'-r');
xlabel('Time (sec)');
ylabel('Amplitude');
title('Reconstructed Speech');
fig3 = figure(3);

audiowrite('reconstructed.wav',OAsn, fs);

