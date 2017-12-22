

t = [0.001:0.001:1];
sigA = sin(2*pi*20.2*t)+0.4*sin(2*pi*30.2*t+0.5);
sigB = sin(2*pi*40.4*t)+0.4*sin(2*pi*60.4*t+0.5);
sigC = sigA(2:2:end)

sigA(1:10)
sigB(1:10)
sigC(1:10)
