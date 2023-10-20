clc;
clear ;
close all;

% -- 积分步长
dt = 0.001;
% -- 求解总时长与求解步数

T = 12;
t = dt:dt:T;
steps = T/dt;

% -- 输入结构参数(质量、刚度、阻尼矩阵)
M = 1;
C = 0;
K = 1;
F = 0;
% -- 积分常数
a0 = 1/(dt)^2;
a1 = 1/(2*dt);
a2 = 2*a0;
a3 = 1/a2;
% -- 分配存储空间
N = T/dt+1;
y   = zeros(1,N);
dy  = zeros(1,N);
ddy = zeros(1,N);

% 赋予初值
  y0 = 1;
 dy0 = 0;
ddy0 = M\(-C*dy0-K*y0);
y_   = y0-dt*dy0+a3*ddy0;

  y(1,1) = y_;
  y(1,2) = y0;
 dy(1,2) = dy0;
ddy(1,2) = ddy0;

Keq = a0*M+a1*C;

for i = 1:steps
    %计算等效荷载

    Feq = F-(K-a2*M)*y(1,i+1)-(a0*M-a1*C)*y(1,i);
      y(1,i+2) = Keq\ Feq ;
     dy(1,i+1) = a1*(y(1,i+2)-y(1,i));
    ddy(1,i+1) = a0*(y(1,i)-2*y(1,i+1)+y(1,i+2));
end

 dy(1,i+2) =  dy(1,i+1);
ddy(1,i+2) = ddy(1,i+1);


plot(t,y(1,3:N+1))
hold on;
plot(t,dy(1,3:N+1))
hold on;
plot(t,ddy(1,3:N+1))







