
function [ dx ] = EoM_function(t,x)
 
global u K
 
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 
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
 
M_c = -K*x;
u = M_c;
 
dx(1) = x(2);
dx(2) = (M_c + x(4)^2*cos(x(1))*sin(x(1))*(IG33-IG11) + omega*cos(x(1))*IG33*x(4))/IG22; 
dx(3) = x(4);
dx(4) = (-mALL*g*GM0*sin(x(3)) - 2*cos(x(1))*sin(x(1))*(IG33-IG11)*x(2)*x(4) - omega*cos(x(1))*IG33*x(2)) / (IB11+mB*dB^2+mG*dG^2 + (cos(x(1)))^2*IG11 + (sin(x(1)))^2*IG33);
dx = dx';
end
 

