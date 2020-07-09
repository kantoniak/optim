% Reflect `x` about `y` with coefficient `mu`
function [z] = reflect_about(x, y, mu)
    z = (1 + mu)*y - mu*x;
end
