clear all;
clc;
syms x

cau_a = exp(x)+2^-x+2*cos(x)-6
[nghiem_cau_a,f_cau_a] = ppTiepTuyen(cau_a,5,10^-3)
[nghiem_cau_a,f_cau_a] = ppDayCung(cau_a,1,5,10^-3)

cau_b = log(x-1)+cos(x-1)
[nghiem_cau_b,f_cau_b] = ppTiepTuyen(cau_b,1.5,10^-3)
[nghiem_cau_b,f_cau_b] = ppDayCung(cau_b,1.1,5,10^-3)

cau_c = (x-2)^2-log(x)
[nghiem_cau_c,f_cau_c] = ppTiepTuyen(cau_c,1.1,10^-3)
[nghiem_cau_c,f_cau_c] = ppDayCung(cau_c,1.1,3,10^-3)

cau_d = sin(x)-exp(-x)
[nghiem_cau_d,f_cau_d] = ppTiepTuyen(cau_d,1.1,10^-3)
[nghiem_cau_d,f_cau_d] = ppDayCung(cau_d,1,5,10^-3)