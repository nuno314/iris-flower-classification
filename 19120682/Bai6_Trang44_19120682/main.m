clear all;
clc;
syms x
f = sin(x)
[I1,delta_I1,I2,delta_I2,I3,delta_I3] = tichPhanGauss(f,0,pi)