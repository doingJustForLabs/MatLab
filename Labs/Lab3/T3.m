clc;

A = [2.34 -1.42 -0.54 0.21; 
    1.44 -0.53 1.43 -1.27;
    0.63 -1.32 -0.65 1.43;
    0.54 0.88 -.67 -2.38];

B = [0.66;
    -1.44;
    0.94;
    0.73];

det_A = det(A);
rank_A = rank(A);
norm_A = norm(A);

cond_A1 = cond(A);

[L, U] = lu(A);
y = L\B;
x_LU = U\y;
x_linsolve = linsolve(A, B);

accuracy_check = (A * x_LU - B);

fprintf("Coefficients matrix:\nDet: %.3f\nRank: %d\nNorm: %.3f\n\n", ...
    det_A, rank_A, norm_A);

fprintf('LU:\n');
fprintf('%10.5f\n', X_obratn_matrix);

fprintf('\nlinsolve:\n');
fprintf('%10.4f\n', X_linsolve);


fprintf('Accuracy\n');
fprintf('%10.1e\n', accuracy_check);

fprintf('\nConditionality of the matrix %.4f\n\n', cond_A);

