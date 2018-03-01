[x Fs] = audioread('my_a2.wav');
pmarks = find_pmarks(x,Fs);
pmarks_w = pmarks(2:end)-pmarks(1:end-1);
target_w = floor(mean(pmarks_w));
y = zeros([target_w*(length(pmarks)-1),1]);
for i = 1:length(pmarks)-1;
    step = (pmarks(i+1)-pmarks(i))/target_w;
    ana_pnt = pmarks(i);
    pnts = pmarks(i):step:pmarks(i+1)-step;
    for j = 1:target_w
        y((i-1)*target_w+1:i*target_w) = x(round(pnts));
    end
end