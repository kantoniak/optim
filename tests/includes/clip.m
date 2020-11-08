function [val] = clip(x, lo, hi)
% -- [val] = clip(x, lo, hi)
%
%     Clips `x` to `[lo, hi]`.

    if (isfinite(lo) && x < lo)
        val = lo;
    elseif (isfinite(hi) && hi < x)
        val = hi;
    else % ((isinf(lo) || lo <= x) && (isinf(hi) || x <= hi))
        val = x;
    end
end
