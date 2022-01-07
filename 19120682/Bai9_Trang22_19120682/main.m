clear all;
clc;
syms x
E = 50000;
I = 30000;
L = 600;
w0 = 2.5;
w = w0 / (120 * E * I*  L) * (-x ^ 5 + 2* L ^ 2 * x ^ 3 - L ^ 4 * x)
dw = diff(w, x)
[fdw, cuc_tri] = PPTiepTuyen(dw, 270, 10^-3, 0, L)
w1 = subs(w, x, 0)
w2 = double(subs(w, x, cuc_tri))
w3 = subs(w, x, L)
max([w1, w2, w3])