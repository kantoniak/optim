function [z] = reflect_about(x, y, mu)
% -- [z] = reflect_about(x, y, mu)
%
%     Reflects `x` about point `y` with coefficient `mu`.

    z = (1 + mu)*y - mu*x;
end
