% [x Fs] = audioread('my_a2.wav');
x = cat_wav;
param.sr = 44100;
[f0 t] = yin_f0(x,param);  %get freq_tbl
t = t + 240;
%240,1.3915
%245,1.4190
%250,1.4012

target_f = 311.12;
pp_f = spline(t,f0);
% f0_dense = ppval(pp_f,t(1):t(end));
% pp_x = spline(t(1):t(end),x(t(1):t(end)));
% ana_pnt = cumsum(target_f./f0_dense)'+1;
% x_str_len = ceil(ana_pnt(end));
y = zeros([length(x)*2,1]);  %create an zero array large enough
ana_pnt  = t(1);
i=1;
while ceil(ana_pnt) < t(end)
%    y(i) = ppval(pp_x,ana_pnt);
   y(i) = x(floor(ana_pnt));
   ana_pnt= ana_pnt+ target_f/ppval(pp_f,ana_pnt);
   i=i+1;
end
disp('done');
y = y(1:i-1); %truncate zero
[y0 t] = yin_f0(y,param);
disp(max(y0)-min(y0));