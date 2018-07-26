%Rich Juszkiewicz
%EEN 540
%Computer Project 2 - Speech Production Using Concatenated Acoustic Tubes

clear;clc;close all;

%Part A

%Objective 1

fs=8000;
c=345;
Tau = 1/(2*fs);
% Vocal Tract lengths for vowels measured every 0.5 cm from glottis to lips')
A=[5 5 5 5 6.5 8 8 8 8 8 8 8 8 6.5 5 4 3.2 1.6 2.6 2.6 2 1.6 1.3 1 0.65 0.65 0.65 1 1.6 2.6 4 1 1.3 1.6 2.6];
E=[8 8 5 5 4 2.6 2 2.6 2.6 3.2 4 4 4 5 5 6.5 8 6.5 8 10.5 10.5 10.5 10.5 10.5 8 8 6.5 6.5 6.5 6.5 1.3 1.6 2 2.6];
I=[4 4 3.2 1.6 1.3 1 0.65 0.65 0.65 0.65 0.65 0.65 0.65 1.3 2.6 4 6.5 8 8 10.5 10.5 10.5 10.5 10.5 10.5 10.5 10.5 10.5 8 8 2 2 2.6 3.2];
O=[3.2 3.2 3.2 3.2 6.5 13 13 16 13 10.5 10.5 8 8 6.5 6.5 5 5 4 3.2 2 1.6 2.6 1.3 0.65 0.65 1 1 1.3 1.6 2 3.2 4 5 5 1.3 1.3 1.6 2.6];
U=[0.65 0.65 0.32 0.32 2 5 10.5 13 13 13 13 10.5 8 6.5 5 3.2 2.6 2 2 2 1.6 1.3 2 1.6 1 1 1 1.3 1.6 3.2 5 8 8 10.5 10.5 10.5 2 2 2.6 2.6];

%set vowel for analysis here
Vowel = fliplr(O);
%calculate l--the length of the vocal tract for male, female and child
%only child is used here.  
l = length(Vowel)*.005;
l_child = l*.5;

%N is the number of tubes needed
N = ceil(l_child/(c*Tau))+1;

%computation for area function spline 
%need short vector for first spline input
short_length_child_vector=[0:l_child/(length(Vowel)-1):l_child];
%need a long vector for desired number of splines
long_length = 0:.0001:l_child;
%calculate area function
area_function = spline(short_length_child_vector, Vowel, long_length);



%plot area function vs. length
figure(1);
subplot(211)
plot(long_length, area_function/2);
hold on
plot(long_length, -area_function/2);
title('Cross-Section Area Function vs. Vocal Tract Length');
xlabel('length (m)');
ylabel('Area (cm^2)');
hold off

%staircase plot using N (number of tubes)
%first need a vector of length N that goes from .005->length
N_length_vector = [0:(l_child/(N-1)):l_child];
%spline calculation for N length vector
N_length_area = spline(long_length, area_function, N_length_vector);

%add fictitious tube on end
fict_N_length_area = [N_length_area 20 20];
fict_N_length_vector = [N_length_vector .096 .1];

%plot staircase 'area function' 
subplot(212)
stairs(fict_N_length_vector, fict_N_length_area/2)
hold on
stairs(fict_N_length_vector, -fict_N_length_area/2)
title('Cross Sectional Area vs. Vocal Tract Length for 6 Lossless Tubes')
xlabel('length (m)');
ylabel('Area (cm^2)');

fig1 = figure(1);

%reflection coefficients
for i=1:(N-1)
    ref_coeff(i)=(N_length_area(i+1)-N_length_area(i))/(N_length_area(i+1)+N_length_area(i));
end
%add on the last coeff
ref_coeff=[ref_coeff 1];
figure(2), stem(ref_coeff)
title('Reflection Coefficients')
xlabel('Coefficient Number')
ylabel('Coefficient Value')

fig2 = figure(2);

%Objective 2 - V(z) Transfer Function
num = zeros(1, (floor(N/2)));
num = [num 1];
Dz = [1 ref_coeff(1)];
for k=2:length(ref_coeff)
    Dz=[Dz 0];
    Dz = Dz + ref_coeff(k)*fliplr(Dz);
end

%plot mag response of lossless TF
[H W] = freqz(num,Dz);
W = (W/pi)*fs/2;
figure(3), plot(W,db(abs(H)))

ref_coeff_lossy = ref_coeff;
ref_coeff_lossy(length(ref_coeff_lossy))=.71;

Dzlossy = [1 ref_coeff_lossy(1)];
for k=2:length(ref_coeff_lossy)
    Dzlossy=[Dzlossy 0];
    Dzlossy = Dzlossy + ref_coeff_lossy(k)*fliplr(Dzlossy);
end

%Objective 3 
RL = -.9;
lossyNum=[num RL];
[Hlossy Wlossy] = freqz(lossyNum,Dzlossy);
Wlossy = (Wlossy/pi)*fs/2;
hold on
plot(Wlossy,db(abs(Hlossy)),'-r')
hold off

xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('Magnitude Response of V(z) and X(z)');
legend('V(z)-Lossless','X(z)-Lossy (alpha = .9)');

fig3 = figure(3);


pitchfreq = 250;
pitchfreqst = int2str(pitchfreq);
pitchperiod = 1/pitchfreq;
%needed to get the desired length of the glottal pulse for 250Hz
negUn = [(-round(fs/2))/pitchfreq:0];
Beta = .85;
gn = conv(Beta.^negUn, Beta.^negUn);
gn = fliplr(gn);
%normalize
gn = gn/max(gn);
%need to get the end of glottal pulse to zero but not change the slope of
%the line
gn = [gn gn(length(gn))/2 gn(length(gn))/4 gn(length(gn))/8 gn(length(gn))/16 gn(length(gn))/32 0];

%need to spline it to get it to be the proper length for the pitch frequency
spline_vector = [0:round(fs/pitchfreq)/(length(gn)-1):round(fs/pitchfreq)];
new_length_spline_vector = [1:round(fs/pitchfreq)];
gn = spline(spline_vector, gn, new_length_spline_vector);
 
longgn = [gn gn gn gn gn gn];
%generate   and normalize
glottal_noise = randn(1,length(longgn));
glottal_noise = glottal_noise/max(glottal_noise);
%add some noise to the glottal pulse
longgn = longgn+0.005*glottal_noise;

time_vector=1/fs*(1:length(longgn));
figure(4);
subplot(211)
plot(time_vector, longgn)
title(strcat('6 Pitch Periods of the Glottal Pulse, F0 = ', pitchfreqst, 'Hz'));
xlabel('Time (sec)');
ylabel('Amplitude');

%Magnitude Response of Glottal Pulse
bins = 1024;
fft_long_gn = fft(longgn,bins);
subplot(212)
freq_vector = [(1/(bins/2))*(fs/2):(1/(bins/2))*(fs/2):fs/2];
plot(freq_vector,db(abs(fft_long_gn(1:bins/2))))
title('Magnitude Response of Glottal Pulse')
xlabel('Frequency (Hz)')
ylabel('Magnitude Response (dB)')

fig4 = figure(4);


%generate 6 pitch periods of speech
short_speech = filter(lossyNum,Dzlossy,longgn);
figure(5);
subplot(211)
plot(time_vector, short_speech)
xlabel('Time (sec)');
ylabel('Amplitude');
title('Six Pitch Periods of Speech (Child "O")')

subplot(212)
fft_short_speech = fft(short_speech,bins);
plot(freq_vector,db(abs(fft_short_speech(1:bins/2))))
xlabel('Frequency (Hz)')
ylabel('Magnitude Response (dB)')
title('Magnitude Response of Six Pitch Periods of Speech')

fig5 = figure(5);

for i=1:7
    longgn = [longgn longgn];
end

long_speech = filter(lossyNum,Dzlossy,longgn);
audiowrite('PartA_longO1_speech.wav',long_speech(1:16000), 8000);

    