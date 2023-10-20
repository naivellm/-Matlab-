clc;
clear ;
close all;

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

Y = zeros(3,N);

% 
y0 = 1;
dy0 = 0;
ddy0 = M\(-C*dy0-K*y0);

Y(1,1) = y0;
Y(2,1) = dy0;
Y(3,1) = ddy0;

for i = 2:N
    K1 = RKK(Y(1:2,i-1),M,C,K);
    K2 = RKK(Y(1:2,i-1)+K1/2*dt,M,C,K);
    K3 = RKK(Y(1:2,i-1)+K2/2*dt,M,C,K);
    K4 = RKK(Y(1:2,i-1)+K3*dt,M,C,K);
    Y(1:2,i) = Y(1:2,i-1)+(K1+2*K2+2*K3+K4)/6*dt;
    Y(3,i) = M\(-C*Y(2,i)-K*Y(1,i));
end

plot(t,Y(1,:))
hold on;
plot(t,Y(2,:))
hold on;
plot(t,Y(3,:))

function   k=RKK(Y,M,C,K)
k=zeros(2,1);
k(1,1)=Y(2,1);
k(2,1)= M\(-C*Y(2,1)-K*Y(1,1));

end








