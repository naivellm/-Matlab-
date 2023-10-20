clc;
clear ;
close all;

global M
global C
global K

% 求解总时长
T = 12;
% 积分步长
dt = 0.001;
t = 0:dt:T;
M = 1;
C = 0;
K = 1;

% 分配存储空间
N = T/dt+1;

% 
y0   = 1;
dy0  = 0;
ddy0 = M\(-C*dy0-K*y0);

Y0 = [y0,dy0];
[t,Y]  = ode45(@fun,t,Y0);
Y(:,3) = M\(0 - C*Y(:,2) - K*Y(:,1));




plot(t,Y(:,1))
hold on;
plot(t,Y(:,2))
hold on;
plot(t,Y(:,3))

function dydt = fun(t,y)
global M
global C
global K

dydt = zeros(2,1);
dydt(1) = y(2);
dydt(2) = M\(0 - C*dydt(1)-K*y(1)) ;
end
















