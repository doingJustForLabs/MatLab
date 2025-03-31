syms x y z

u = x*sin(y)+z^(3/2);

% частные производные
x_val = -3.59;
y_val = 0.467;
z_val = 563.2;

delta_x = 0.01;
delta_y = 0.001;
delta_z = 0.1;

du_dx = diff(u, x);
du_dy = diff(u, y);
du_dz = diff(u, z);

% значение функции
u_val = double(subs(u, [x, y, z], [x_val, y_val, z_val]))
% значения частных производных
du_dx_val = double(subs(du_dx, [x y z], [x_val y_val z_val]));
du_dy_val = double(subs(du_dy, [x y z], [x_val y_val z_val]));
du_dz_val = double(subs(du_dz, [x y z], [x_val y_val z_val]));

% абсолютная погрешность
delta_u = abs(du_dx_val) * delta_x + abs(du_dy_val) * delta_y + abs(du_dz_val) * delta_z
% относительная погрешность функции
relat_delta_u = delta_u/abs(u_val)