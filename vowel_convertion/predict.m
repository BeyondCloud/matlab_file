y = zeros(size(Xia_i));
y_pred(y_pred<=0) = 0;
yy = [y_pred;flipud(y_pred)];

for f = 1:150
    syn_pnt =(f-1)*Nh+1;
    y(syn_pnt:syn_pnt+N-1) = y(syn_pnt:syn_pnt+N-1)+...
                            ifft(yy(:,f).*a_pha(:,f));
end
y = real(y);
%remove DC
rx=randn([16,1]);
y=fftfilt(rx-mean(rx),y);
