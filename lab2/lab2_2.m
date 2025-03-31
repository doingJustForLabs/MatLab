%2
syms x y z

u = (x^3*y^2)/(z^4);

% частные производные
du_dx = diff(u, x);
du_dy = diff(u, y);
du_dz = diff(u, z);

x_val = 37.1;
y_val = 9.87;
z_val = 6.052;

delta_x = 0.1;
delta_y = 0.05;
delta_z = 0.02;

% значение функции
u_val = double(subs(u, [x, y, z], [x_val, y_val, z_val]))

% значения частных производных
du_dx_val = double(subs(du_dx, [x, y, z], [x_val, y_val, z_val]));
du_dy_val = double(subs(du_dy, [x, y, z], [x_val, y_val, z_val]));
du_dz_val = double(subs(du_dz, [x, y, z], [x_val, y_val, z_val]));

% абсолютная погрешность
delta_u = abs(du_dx_val) * delta_x + abs(du_dy_val) * delta_y + abs(du_dz_val) * delta_z
% относительная погрешность функции
relat_delta_u = delta_u/abs(u_val)