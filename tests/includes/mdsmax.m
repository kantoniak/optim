function [x, fmax, nf] = mdsmax(fun, x, options, varargin)
% -- [x, fmax, nf] = mdsmax(fun, x, options, varargin)
%
%     Original `mdsmax` implementation, modified for Matlab cooperability.

[stopit, savit, dirn, trace, tol, maxiter, tol_f, outfcn] = parse_options(options, x);

x0 = x(:);  % Work with column vector internally.
n = length(x0);

mu = 2;      % Expansion factor.
theta = 0.5; % Contraction factor.

% Set up convergence parameters etc.
if nargin < 3
	stopit(1) = 1e-3;
elseif isempty(stopit)
	stopit(1) = 1e-3;
end
tol = stopit(1);  % Tolerance for cgce test based on relative size of simplex.
if length(stopit) == 1, stopit(2) = inf; end  % Max no. of f-evaluations.
if length(stopit) == 2, stopit(3) = inf; end  % Default target for f-values.
if length(stopit) == 3, stopit(4) = 0; end    % Default initial simplex.
if length(stopit) == 4, stopit(5) = 1; end    % Default: show progress.
trace  = stopit(5);
if length(stopit) == 5, stopit(6) = 1; end    % Default: maximize
dirn= stopit(6);
if nargin < 4, savit = []; end                   % File name for snapshots.

V = [zeros(n,1) eye(n)]; T = V;
f = zeros(n+1,1); ft = f;
V(:,1) = x0; f(1) = dirn*feval(fun,x,varargin{:});
fmax_old = f(1);

if trace, fprintf('f(x0) = %9.4e\n', f(1)), end

k = 0; m = 0;
full_iter = 0;

% Set up initial simplex.
scale = max(norm(x0,inf),1);
if stopit(4) == 0
   % Regular simplex - all edges have same length.
   % Generated from construction given in reference [18, pp. 80-81] of [1].
   alpha = scale / (n*sqrt(2)) * [ sqrt(n+1)-1+n  sqrt(n+1)-1 ];
   V(:,2:n+1) = (x0 + alpha(2)*ones(n,1)) * ones(1,n);
   for j=2:n+1
       V(j-1,j) = x0(j-1) + alpha(1);
       x(:) = V(:,j); f(j) = dirn*feval(fun,x,varargin{:});
   end
else
   % Right-angled simplex based on co-ordinate axes.
   alpha = scale*ones(n+1,1);
   for j=2:n+1
       V(:,j) = x0 + alpha(j)*V(:,j);
       x(:) = V(:,j); f(j) = dirn*feval(fun,x,varargin{:});
   end
end
nf = n+1;
size = 0;         % Integer that keeps track of expansions/contractions.
flag_break = 0;   % Flag which becomes true when ready to quit outer loop.

% Add sorting before first iteration
[fmax,j] = max(f);
V(:,[1 j]) = V(:,[j 1]); v1 = V(:,1);
if ~isempty(savit), x(:) = v1; eval(['save ' savit ' x fmax nf']), end
f([1 j]) = f([j 1]);

how = "initial  ";
if (~isempty (outfcn))
    optimvalues.iteration = 0;
    optimvalues.funccount = nf;
    optimvalues.fval = dirn * f(1);
    optimvalues.procedure = how;
    state = "init";
    stop = outfcn (x, optimvalues, state);
    if (stop)
      msg = "Stopped by OutputFcn\n";
    end
  end

while 1    %%%%%% Outer loop.
k = k+1;

% Find a new best vertex  x  and function value  fmax = f(x).
[fmax,j] = max(f);
V(:,[1 j]) = V(:,[j 1]); v1 = V(:,1);
if ~isempty(savit), x(:) = v1; eval(['save ' savit ' x fmax nf']), end
f([1 j]) = f([j 1]);
if trace == 1
   fprintf('Iter. %2.0f,  inner = %2.0f,  size = %2.0f,  ', k, m, size)
   fprintf('nf = %3.0f,  f = %9.4e  (%2.1f%%)\n', nf, fmax, ...
           100*(fmax-fmax_old)/(abs(fmax_old)+eps))
end
fmax_old = fmax;

% Stopping Test 1 - f reached target value?
if fmax >= stopit(3)
   msg = ['Exceeded target...quitting\n'];
   break  % Quit.
end

m = 0;
while 1   %%% Inner repeat loop.
    m = m+1;
    full_iter = full_iter + 1;

    % Stopping Test 2 - too many f-evals?
    if nf >= stopit(2)
       msg = ['Max no. of function evaluations exceeded...quitting\n'];
       flag_break = 1; break  % Quit.
    end

    % Stopping Test 3 - converged?   This is test (4.3) in [1].
    size_simplex = norm(V(:,2:n+1)- v1(:,ones(1,n)),1) / max(1, norm(v1,1));
    if size_simplex <= tol
       msg = sprintf('Simplex size %9.4e <= %9.4e...quitting\n', ...
                      size_simplex, tol);
       flag_break = 1; break  % Quit.
    end

    for j=2:n+1      % ---Rotation (reflection) step.
        T(:,j) = 2*v1 - V(:,j);
        x(:) = T(:,j); ft(j) = dirn*feval(fun,x,varargin{:});
    end
    nf = nf + n;

    replaced = ( max(ft(2:n+1)) > fmax );

    if replaced
       for j=2:n+1   % ---Expansion step.
           V(:,j) = (1-mu)*v1 + mu*T(:,j);
           x(:) = V(:,j); f(j) = dirn*feval(fun,x,varargin{:});
       end
       nf = nf + n;
       % Accept expansion or rotation?
       if max(ft(2:n+1)) > max(f(2:n+1))
          V(:,2:n+1) = T(:,2:n+1);  f(2:n+1) = ft(2:n+1);  % Accept rotation.
          how = "reflect";
       else
          size = size + 1;  % Accept expansion (f and V already set).
          how = "expand";
       end
    else
       for j=2:n+1   % ---Contraction step.
           V(:,j) = (1+theta)*v1 - theta*T(:,j);
           x(:) = V(:,j); f(j) = dirn*feval(fun,x,varargin{:});
       end
       nf = nf + n;
       replaced = ( max(f(2:n+1)) > fmax );
       % Accept contraction (f and V already set).
       size = size - 1;
       how = "contract";
    end

    % Call OutputFcn
    if (~isempty (outfcn))
      optimvalues.funccount = nf;
      optimvalues.fval = dirn * f(1);
      optimvalues.iteration = full_iter;
      optimvalues.procedure = how;
      state = "iter";
      stop = outfcn (x, optimvalues, state);
      if (stop)
        msg = "Stopped by OutputFcn\n";
        flag_break = 1;
        break;
      end
    end

    if replaced, break, end
    if (trace && rem(m, 10) == 0)
      fprintf('        ...inner = %2.0f...\n', m);
    end
    end %%% Of inner repeat loop.

if flag_break, break, end
end %%%%%% Of outer loop.

% Finished.
if trace, fprintf(msg), end
x(:) = v1;

end
