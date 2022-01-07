clear all;
clc;
syms x
% Cau a
f = exp(x)+2^-x+2*cos(x)-6
[xa,fa] = ppChiaDoi(f,-10,10,10^-3)
phi_a = log(6-2*cos(x)-2^-x)
[xa,fa] = ppLap(f,phi_a,0,10^-3)

% Cau b
f = log(x-1)+cos(x-1)
[xb,fb] = ppChiaDoi(f,1.1,10,10^-3)
phi_b = exp(-cos(x-1))+1
[xb,fb] = ppLap(f,phi_b,0,10^-3)

% Cau c
f = (x-2)^2-log(x)
[xc,fc] = ppChiaDoi(f,1.1,5,10^-3)
phi_c = sqrt(log(x))+2
[xc,fc] = ppLap(f,phi_c,5,10^-3)

% Cau d
f = sin(x)-exp(-x)
[xd,fd] = ppChiaDoi(f,1.1,5,10^-3)
phi_d = asin(exp(-x))
[xd,fd] = ppLap(f,phi_d,5,10^-3)