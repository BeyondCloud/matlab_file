%overshoot
% w=0.0348, zera=0.5422,k= 0.0348;
%vibrato (0.0345, 0, 0.0018)
% w=0.0345, zera=0,k= 0.0018;
%preparation d (0.0292, 0.6681, 0.0292)
w=0.0292, zera=0.6681,k= 0.0292;

H = tf(k,[1,2*zeta*w,w^2])
stepplot(H)
