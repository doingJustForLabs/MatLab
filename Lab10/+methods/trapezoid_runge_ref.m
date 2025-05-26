function [new_trap_result] = trapezoid_runge_ref(f, a, b, h_max)    
    h_new = h_max / 2;
    n_new = ceil((b - a) / h_new);
    x_new = linspace(a, b, n_new+1);
    y_new = f(x_new);
    new_trap_result = (b - a) / (2*n_new) * (y_new(1) + 2*sum(y_new(2:end-1)) + y_new(end));
end