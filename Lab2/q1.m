clear;
clc;

x = 2.5378;
Dx = 0.0001;
y = 2.536;
Dy = 0.001;

dx = 3.94 * 10^-5;
dy = 3.94 * 10^-4;

S1 = x + y
S2 = x - y;

DS1 = Dx + Dy;
DS2 = Dx + Dy;

delta_S1 = DS1 / S1
delta_S2 = DS2 / S2

test = (delta_S2 / delta_S1) > 1600