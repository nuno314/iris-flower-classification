clear all;
clc;
syms x
% Cau a
f = exp(x)+2^-x+2*cos(x)-6
[xa, fa] = PPTiepTuyen(f,5,10^-3)
[xb, fb] = PPDayCung(f,1,5,10^-3)

% Cau b
f = log(x-1)+cos(x-1)
xb, fb = PPTiepTuyen(f,1.5,10^-3)
xb,fb = PPDayCung(cau_b,1.1,5,10^-3)

%Cau c
f = (x-2)^2-log(x)
[xc,fc] = PPTiepTuyen(cau_c,1.1,10^-3)
[xc,fc] = PPDayCung(cau_c,1.1,3,10^-3)

% Cau d	
f = sin(x)-exp(-x)
[xd,fd] = PPTiepTuyen(cau_d,1.1,10^-3)
[xd,fd] = PPDayCung(cau_d,1,5,10^-3)