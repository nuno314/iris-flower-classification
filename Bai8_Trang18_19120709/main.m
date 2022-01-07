clear all;
clc;
syms x

cau_a = exp(x)+2^-x+2*cos(x)-6
[nghiem_cau_a,f_cau_a] = ppChiaDoi(cau_a,-10,10,10^-3)
phi_a = log(6-2*cos(x)-2^-x)
[nghiem_cau_a,f_cau_a] = ppLap(cau_a,phi_a,0,10^-3)

cau_b = log(x-1)+cos(x-1)
[nghiem_cau_b,f_cau_b] = ppChiaDoi(cau_b,1.1,10,10^-3)
phi_b = exp(-cos(x-1))+1
[nghiem_cau_b,f_cau_b] = ppLap(cau_b,phi_b,0,10^-3)

cau_c = (x-2)^2-log(x)
[nghiem_cau_c,f_cau_c] = ppChiaDoi(cau_c,1.1,5,10^-3)
phi_c = sqrt(log(x))+2
[nghiem_cau_c,f_cau_c] = ppLap(cau_c,phi_c,5,10^-3)

cau_d = sin(x)-exp(-x)
[nghiem_cau_d,f_cau_d] = ppChiaDoi(cau_d,1.1,5,10^-3)
phi_d = asin(exp(-x))
[nghiem_cau_d,f_cau_d] = ppLap(cau_d,phi_d,5,10^-3)