[Xia_i fs] = audioread('Xia_i_E4.wav');
[Xia_a fs] = audioread('Xia_a_E4.wav');
Xia_i = Xia_i(1:88200);
N = 1024;
Nh = N/2;
w = hamming(N);
frames = floor(2*length(Xia_i-N)/N)-1;
i_Xn = zeros(N,frames);
a_Xn = zeros(N,frames);

i_pha =  zeros(N,frames);
a_pha =  zeros(N,frames);

for f = 1:frames 
    i_block = Xia_i((f-1)*Nh+1:(f-1)*Nh+N);
    a_block = Xia_a((f-1)*Nh+1:(f-1)*Nh+N);
    
    i_Xn(:,f) = fft(i_block.*w,N);
    a_Xn(:,f) = fft(a_block.*w,N);
    
    i_pha(:,f) = i_Xn(:,f)./abs(i_Xn(:,f));
    a_pha(:,f) = a_Xn(:,f)./abs(a_Xn(:,f));
   
end
y = zeros(size(Xia_i));
phase_shift = 0;
% i_Xn = i_Xn(:,randperm(size(i_Xn, 2)));
for f = 1:frames-phase_shift
    syn_pnt =(f-1)*Nh+1;
    y(syn_pnt:syn_pnt+N-1) = y(syn_pnt:syn_pnt+N-1)+...
                            ifft(abs(i_Xn(:,f)).*a_pha(:,f+phase_shift));
end
a_train = abs(a_Xn(1:512,:));
i_label = abs(i_Xn(1:512,:));
save('Xia_A.mat','a_train');
save('Xia_i.mat','i_label');

% sound(y,fs);