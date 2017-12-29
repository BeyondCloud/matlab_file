
clc;clear;
t = [0.001:0.001:4];
sigA = sin(2*pi*20.2*t)+0.4*sin(2*pi*30.2*t+0.5);
sigB = sin(2*pi*40.4*t)+0.4*sin(2*pi*60.4*t+0.5);
sigC = sigA(2:2:end);

sigA(1000:1010)
sigB(1000:1010)
sigC(1000:1010)
