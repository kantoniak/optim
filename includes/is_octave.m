function retval = is_octave()
% -- retval = is_octave()
%
%     Checks if current environment is Octave.

    persistent cacheval;  % speeds up repeated calls

    if isempty(cacheval)
      cacheval = (exist('OCTAVE_VERSION', 'builtin') > 0);
    end

    retval = cacheval;
end
