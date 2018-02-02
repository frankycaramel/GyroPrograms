clc;clear;


global u K
 
first_time1=0;
 
mB = 15;
mP = 80;
rG = 0.1;
tG = 0.05;
mG = rG^2*pi*tG*8550;
mALL = mB+mG+mP;
wB = 0.1;
hB = 1;
L = 1.5;
Zwl = 0;
dG = 0.7-Zwl;
dB = 1.3;
GM0 = 0.1;
omega = 1047;
g = 9.81;
 
 
IG11 = mG*(3*rG^2+tG^2)/12;
IG22 = IG11;
IG33 = mG*rG^2/2;
IB11 = mB*(hB^2+wB^2)/12;
 
a1 = omega*IG33/IG22;
a2 = -omega*IG33/(IB11+mB*dB^2+mG*dG^2+IG11);
a3 = -mALL*g*GM0/(IB11+mB*dB^2+mG*dG^2+IG11);
b1 = 1/IG22;
 
if first_time1==0;
A = [0 1 0 0; 0 0 0 a1; 0 0 0 1; 0 a2 a3 0];
B = [0; b1; 0; 0];
C = [1 0 1 0];
D = 0;
SYS = ss(A,B,C,D);
G = tf(SYS);
P = [-30 -30 -30 -30];
K = acker(A,B,P);
first_time1=1;
end
 
deg2rad = 0.0174532925;
rad2deg = 57.2957795;
IC = [0*deg2rad 0*deg2rad 15*deg2rad 0*deg2rad];
Tf = 2;
del =.01;
N = Tf/del;
DATA = [0 IC];
UDAT = [0];
 
for ks = 1:N;
len = length(DATA(:,1));
t1 = DATA(len,1);
x(1) = DATA(len,2);
x(2) = DATA(len,3);
x(3) = DATA(len,4);
x(4) = DATA(len,5);
T_out(ks)=[omega*cos(x(1))*IG33*x(2)];
%Reset the Initial Conditions
IC = [x(1) x(2) x(3) x(4)];
%Do the simulation
ks*del
[T,Y] = ode45('EoM_function',[(ks-1)*del ks*del],IC);
%Record the data for the last time period
DATA = [DATA; T(length(T)) Y(length(Y),:)];
UDAT = [UDAT; u];
end;
 
T_out(ks+1)=omega*cos(DATA(len+1,2))*IG33*DATA(len+1,3);
T_out=T_out';
 
t=DATA(:,1);
theta=DATA(:,2)*rad2deg;
theta_dot=DATA(:,3)*rad2deg;
rho=DATA(:,4)*rad2deg;
rho_dot=DATA(:,5)*rad2deg;
uplot=UDAT(:,1);
max_torque=max(abs(T_out));
 
figure;
subplot(411)
plot(t, theta)
ylabel('angle of gyro [deg]')
 
grid on
subplot(412)
plot(t,rho)
ylabel('angle of vehicle [deg]')
 
grid on
subplot(413)
plot(t,uplot)
ylabel('Gimbal motor torque')
 
grid on
subplot(414)
plot(t,T_out)
ylabel('Precession torque')
xlabel('time [s]')
grid on
