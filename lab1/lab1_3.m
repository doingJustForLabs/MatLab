%3
f = @ (x) x^2;
f1 = inline('x^2', 'x');
disp(f(4));
disp(f1(2.5));
Z = functions(@sin);
disp(Z);
format short
format long
expr = str2sym('2*x+3*y');
disp(expr);