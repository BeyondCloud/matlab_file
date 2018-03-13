% Assume x's pitch is normalized already
[x Fs] = audioread('Xia_a_C3.wav');

%define frq_tbl 
start_f = 1.2;
end_f = 2;
del_f =end_f - start_f ;
x_len = length(x);
f_tbl = [start_f:del_f/(x_len-2):end_f];

% f_tbl = abs(0.2*sin(40*t*2*pi/x_len)+1.5);
f_tbl_cum = cumsum(f_tbl);
stretch_ratio = f_tbl_cum(end)/(x_len-1);

%%%stretching input x
x_str = wsolaTSM(x,stretch_ratio);
yy = zeros(size(x));
yy(1) = x_str(1);
yy(2:end) = spline(1:length(x_str),x_str,f_tbl_cum(1:end));

% formant preservation
clear parameter
parameter.anaHop = 512;
parameter.win = win(2048,1); % sin window
parameter.filterLength = 60;
final = modifySpectralEnvelope(yy,x,parameter);
