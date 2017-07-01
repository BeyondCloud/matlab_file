clear;
clc;
time = 1;
freq = 441;
sr = 44100;
cycle = round(sr/freq);
delta_x = 2/cycle;
x = 0;
x_out = 0.1;
y_out = zeros(1, sr*time);
for i = 1:sr*time
    peak_y = sign(delta_x)*sin(x*pi);
    if(x > x_out)
        y = peak_y*((x_out)/(x));
    else
        y = peak_y*((1-x_out)/(1-x));
    end
    y_out(i) = y;
    x = x+ delta_x;
    if(x > 1 || x < 0)
        delta_x = -delta_x;
        x = x+ delta_x; 
    end
end
plot(y_out);
%figure;
% for t=1:100
%     hold off;
%     plot([0 pi*t/100],[0 sin(pi*t/100)]);
%     hold on;
%     plot([pi pi*t/100],[0 sin(pi*t/100)]); 
%     axis([0 pi -1 1]);
%     pause(0.01);
% end
% for t=100:-1:1
%     hold off;
%     plot([0 pi*t/100],[0 -sin(pi*t/100)]);
%     hold on;
%     plot([pi pi*t/100],[0 -sin(pi*t/100)]); 
%     axis([0 pi -1 1]);
%     pause(0.01);
% end
