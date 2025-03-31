% Лаб. 2
x = 2.5378;
y = 2.536;

dx = 0.0001;
dy = 0.001;

s1 = x + y;
s2 = x - y;
% абсолютные погрешности суммы и разности
abs_d_sum = dx + dy
abs_d_razn = dx + dy
% относительные погрешности суммы и разности
relat_pogr_s1 = abs_d_sum/abs(s1)
relat_pogr_s2 = abs_d_sum/abs(s2)