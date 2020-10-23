% Starting point for extended Rosenbrock function.
function [x0] = rosenbrock_point(n)

    % Enforce divisibility by 2
    if mod(n, 2) ~= 0
        error('xoptim:incorrectDimension', 'Error.\nInput vector dimension %d not divisible by 2.', n);
    end

    % Compute value
    x0 = [];
    for i = 1:(n/2)
        x0(2*(i-1)+1) = -1.2;
        x0(2*(i-1)+2) = 1;
    end

end
