clear all;
clc;
syms x y
f = 2*x^2+y
y0 = 1
a=0; b=0.5; h=0.1;
[y1,y2] = ppEuler(f,a,b,h,y0)