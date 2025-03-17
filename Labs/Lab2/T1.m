clc;
clear all;

function lae = lim_abs_error(x)
    nx = length(num2str(x)) - 1;
    lx = floor(log10(x) - nx + 2);
    lae = 0.5 * 10^lx;
end

x = 2.5378;     
y = 2.536;

delta_x = 0.0001;
delta_y = 0.001;

relative_x = 3.94*10^-5;
relative_y = 3.94*10^-4;

s1 = x + y;
s2 = x - y;

s1_lae = lim_abs_error(x) + lim_abs_error(y)
s1_lre = s1_lae / s1

s2_lae = lim_abs_error(x) + lim_abs_error(y)
s2_lre = s2_lae / s2
