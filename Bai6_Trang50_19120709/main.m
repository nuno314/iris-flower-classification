clear all;
clc;
syms x y
f = 2*x^2+y
y0 = 1
y = pp_R_K(f,0,0.5,0.1,y0)