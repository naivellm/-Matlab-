clc;
clear ;
close all;

% -- 积分步长
dt = 0.001;
% -- 求解总时长与求解步数

T = 12;
t = 0:dt:T;
steps = T/dt;

% -- 输入结构参数(质量、刚度、阻尼矩阵)
M = 1;
C = 0;
K = 1;
F = 0;
% -- 积分常数
delta = 1/2;
beta  = 1/2;
a0 = 1/(beta*dt^2);
a1 = delta/(beta*dt);
a2 = 1/(beta*dt);
a3 = 1/2*beta-1;
a4 = delta/beta-1;
a5 = dt/2*(delta/beta-2);
a6 = dt*(1-delta);
a7 = delta*dt;
% -- 分配存储空间
N = T/dt+1;
y   = zeros(1,N);
dy  = zeros(1,N);
ddy = zeros(1,N);

% 赋予初值
  y0 = 1;
 dy0 = 0;
ddy0 = M\(-C*dy0-K*y0);


  y(1,1) = y0;
 dy(1,1) = dy0;
ddy(1,1) = ddy0;

Keq = a0*M+a1*C+K;

for i = 2:steps
    %计算等效荷载
    Req = M*(a0*y(1,i-1)+a2*dy(1,i-1)+a3*ddy(1,i-1))+C*(a1*y(1,i-1)+a4*dy(1,i-1)+a5*ddy(1,i-1));
      y(1,i) = Keq\ Req ;
    ddy(1,i) = a0*(y(1,i)-y(1,i-1))-a2*dy(1,i-1)-a3*ddy(1,i-1);
     dy(1,i) = dy(1,i-1)+a6*ddy(1,i-1)+a7*ddy(1,i);
end

plot(t,y(1,:))
hold on;
plot(t,dy(1,:))
hold on;
plot(t,ddy(1,:))







