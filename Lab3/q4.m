clc;
clear;

substances = ["Na2CO3","HNO3","NaNO3","H2O","CO2","CaO","Ca(NO3)2"];

A = [2 1 3 0 0 0;
    0 0 3 1 1 0;
    1 0 3 0 1 0;
    0 0 1 2 0 0;
    0 1 2 0 0 0;
    0 0 1 0 0 1;
    0 0 6 0 2 1];

rank_A = rank(A);
norm_A = norm(A);

syms b11 b12 b13 b14 b15 b16 b17 
syms b21 b22 b23 b24 b25 b26 b27
fprintf('\nConditionality of the matrix %.4f\n\n', cond(A));

B1 = [1 0 b13 b14 b15 b16 b17;
     0 1 b23 b24 b25 b26 b27];
sys1 = B1 * A == 0;
sol1 = solve(sys1, [b11 b12 b13 b14 b15 b16 b17 b21 b22 b23 b24 b25 b26 b27]);
sol1.b11 = 1;
sol1.b12 = 0;
sol1.b21 = 0;
sol1.b22 = 1;

B2 = [1 b12 b13 b14 b15 b16 0;
     0 b22 b23 b24 b25 b26 1];
sys2 = B2 * A == 0;
sol2 = solve(sys2, [b11 b12 b13 b14 b15 b16 b17 b21 b22 b23 b24 b25 b26 b27]);
sol2.b11 = 1;
sol2.b17 = 0;
sol2.b21 = 0;
sol2.b27 = 1;

sol1 = double(structfun(@double, sol1))';
sol2 = double(structfun(@double, sol2))';

coeffs1 = sol1(1:7);
coeffs2 = sol1(8:14);
coeffs3 = sol2(1:7);
coeffs4 = sol2(8:14);


function reaction = create_reaction(substances, coefficients)
    reactants = "";
    products = "";

    for i = 1:length(substances)
        if coefficients(i) < 0

            if reactants ~= ""
                plus = " + ";
            else
                plus = "";
            end

            if abs(coefficients(i)) == 1
                reactants = reactants + plus + substances(i);
            else
                reactants = reactants + plus + string(abs(coefficients(i))) + substances(i);
            end

        elseif coefficients(i) > 0

            if products ~= ""
                plus = " + ";
            else
                plus = "";
            end


            if abs(coefficients(i)) == 1
                products = products + plus + substances(i);
            else
                products = products + plus + string(abs(coefficients(i))) + substances(i);
            end
        end
    end

    reaction = reactants + " -> " + products;
    disp(reaction)
end

disp("Реакция 1:");
reaction1 = create_reaction(substances, coeffs1);

disp("Реакция 2:");
reaction2 = create_reaction(substances, coeffs2);

disp("Реакция 3:");
reaction3 = create_reaction(substances, coeffs3);

disp("Реакция 4:");
reaction4 = create_reaction(substances, coeffs4);