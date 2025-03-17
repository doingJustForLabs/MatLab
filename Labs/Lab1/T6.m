clear all;
clc;

%a)
disp('a)')
syms x y
(x-y)*(x-y)^2

%b)
disp('b)')
simplify((x^3-y^3)/(x-y))

%c)
disp('c)')
cos(pi/2)
cos(sym(pi/2))

sym('1/2')+sym('1/3')