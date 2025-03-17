clc;
clear all;

x = 37.1;
y = 9.87;
z = 6.052;

dx = 0.1;
dy = 0.05;
dz = 0.02;

u = ((x^2) * (y^2)) / (z^4);

dudx = (2*x*(y^2)) / (z^4);
dudy = (2*(x^2)*y) / (z^4);
dudz = (-4*(x^2)*(y^2)) / (z^5);

du = abs(dudx) * dx + abs(dudy) * dy + abs(dudz) * dz

delta_u = du / u