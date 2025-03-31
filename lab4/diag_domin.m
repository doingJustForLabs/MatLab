% diag_domin.m
function [A, b] = diag_domin(A, b)
    % D - любая матрица с диагональным преобладанием
    D = [7 2 2 2;
         2 7 2 2;
         2 2 7 2;
         2 2 2 7];

    B = D * inv(A);
    b = B * b;
    A = D;
    return;
end

% Пояснения
% Ax = b
% B = D * A^(-1)
% Dx = B * b