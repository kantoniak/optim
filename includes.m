1; % Make file executable

% Add define to check if file loaded
EXTRA_OPTIM_LOADED = true;

function ret_val = suppress_warnings(fun)
    % Save warning settings
    w = warning();
    warning('off');
    ret_val = fun();
    warning(w);
end

function retval = is_octave()
    persistent cacheval;  % speeds up repeated calls

    if isempty(cacheval)
      cacheval = (exist('OCTAVE_VERSION', 'builtin') > 0);
    end

    retval = cacheval;
end

function [padded] = pad_left(str, numberOfCharacters, padCharacter)
    if is_octave()
        str_length = length(str);
        to_add = numberOfCharacters - str_length;
        padded = cstrcat(cstrcat(repmat(padCharacter, 1, to_add)), str);
    else
        padded = pad(str, numberOfCharacters, 'left', padCharacter);
    end
end

function [verbosity_level] = parse_display_option(options)
    display = optimget(options, 'Display', 'notify');
    switch display
        case 'iter'
            verbosity_level = 3;
        case 'final'
            verbosity_level = 2;
        case 'notify'
            verbosity_level = 1;
        otherwise
            verbosity_level = 0;
    end
end

function iter_display_header()
    minfx_str = pad_left('min f(x)', 17, ' ');
    printf('Iteration    Func-count    %s    Procedure\n', minfx_str);
end

function iter_display_row(iter, fcount, fmin, procedure)
    fmin_str = pad_left(num2str(fmin, '%16.10f'), 17, ' ');
    printf('%9.0f    %10.0f    %s    %-15s\n', iter, fcount, fmin_str, procedure);
end

function [sigma_plus] = simplex_max_oriented_length(S)
% -- [sigma_plus] = simplex_max_oriented_length(S)
%
%     Compute max oriented length of a simplex S. Simplex points are
%     represented as matrix columns.
    N = size(S, 1);
    V = S(:, 2:N+1) - S(:, ones(1,N));
    sigma_plus = max(max(abs(V)));
end

% Reflect `x` about `y` with coefficient `mu`
function [z] = reflect_about(x, y, mu)
    z = (1 + mu)*y - mu*x;
end

% Sort `f` and apply the same permutation to columns of `X`
function [Xs, fs] = sort_by_values(X, f)
    [~, i] = sort(f);    % I holds sorting order
    Xs = X(:,i);         % apply this order to vector
    fs = f(i);
end
