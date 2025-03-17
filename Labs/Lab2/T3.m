clc;
clear all;

x = -3.59;
y = 0.467;
z = 563.2;

dx = 0.01;
dy = 0.001;
dz = 0.1;

f = x * sin(y) + z^(1/3);

dfdx = sin(y);
dfdy = x * cos(y);
dfdz = (1/3) * z^(-2/3);

df = abs(dfdx) * dx + abs(dfdy) * dy + abs(dfdz) * dz

delta_f = df / f
