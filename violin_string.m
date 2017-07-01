%======================
%This program simulate 2D string using finite difference
%=====================

clc;
clear;
figure;
samp_pnt = 20;
plk = 3;
plk_y = 1;
plk = min(plk,samp_pnt-1);
str_len = 1; %meter
del_t=0.01;%sec
k = 800;
m = 1;
rho = 50; %piano string = 0.01 kg/m
T = 400;  %piano string = 400N

%syms c;
%init position==========================
node_y(1:plk) = linspace(0,plk_y,plk);
node_y(plk:samp_pnt) = linspace(plk_y,0,samp_pnt-plk+1);
%=======================================

node_y_prev = node_y;
node_y_next(1:samp_pnt) = 0;

node_x(1:samp_pnt) = linspace(0,str_len,samp_pnt);


del_x = str_len/(samp_pnt-1);
out(1:1000) = 0;

plot(node_x,node_y,'b--o','MarkerFaceColor','g','Markersize',5);


for j = 1:256
     for i = 2:samp_pnt-1
%        T1 = k*(sqrt( (node_y(i-1) - node_y(i))^2 +(node_x(i-1) - node_x(i))^2)...
%            - str_len/del_x);
%         T2 = k*(sqrt(((node_y(i+1) - node_y(i))^2 +(node_x(i+1) - node_x(i))^2))...
%             - str_len/del_x);
%         theta_1 = atan((node_y(i) - node_y(i-1))/(node_x(i) - node_x(i-1)));
%         theta_2 = atan((node_y(i+1) - node_y(i))/(node_x(i+1) - node_x(i))); 
%         ty1 = T1*sin(theta_1);
%         ty2 = T2*sin(theta_2);
%         tx1 = T1*cos(theta_1);
%         tx2 = T2*cos(theta_2);
%         ty_total = ty1+ty2;
%         tx_total = tx2-tx1;
%         ax = tx_total/m;
%         ay = ty_total/m;
%         v0x = (node_x(i)-node_x_prev(i))/del_t;
%         v0y = (node_y(i)-node_y_prev(i))/del_t;
%        
%         node_y_next(i) = solve(   ((2*node_y(i) -node_y(i-1) - node_y(i+1))/del_x) ==...
%             (rho)*((2*node_y(i)-node_y_prev(i)-c)/del_t),c);
     node_y_next(i) = -((2*node_y(i) -node_y(i-1) - node_y(i+1))/del_x^2)*(del_t)^2*T/rho+...
        (2*node_y(i)-node_y_prev(i));
     end
    plot(node_x,node_y,'b--o','MarkerFaceColor','g','Markersize',5);
    %out(j) = node_y(round(samp_pnt/2));
    axis([0 str_len -2 2]);
    node_y_prev = node_y;
    node_y = node_y_next;
    pause(0.01);
end

% for t = 0:256
%     for i = 2:49
%         Ty1 = k*(sqrt((node(i-1) - node(i))^2 + 1^2) - 1);
%         Ty2 = k*(sqrt((node(i+1) - node(i))^2 + 1^2) - 1);
%         
%         
%         ty1 = Ty1*sin(atan(node(i-1) - node(i)/1));
%         ty2 = Ty2*sin(atan(node(i+1) - node(i)/1));
%         
%         t_total = ty1+ty2;
%         a = t_total/m;
%         v0 = node(i)-node_prev(i);
%         node_next(i) = v0*0.8 + 0.5*a*0.01;
%     end
%     plot(node_next,'b--o','MarkerFaceColor','g','Markersize',5);
%     axis([0 50 -2 2])
%     node_prev = node;
%     node = node_next;
%     pause(0.1);
% end
