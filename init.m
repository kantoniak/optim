addpath(strcat(pwd()));
addpath(strcat(pwd(), filesep, 'includes'));
addpath(strcat(pwd(), filesep, 'examples', filesep, 'includes'));
addpath(strcat(pwd(), filesep, 'tests', filesep, 'functions'));
addpath(strcat(pwd(), filesep, 'tests', filesep, 'includes'));

if is_octave()
    eval('pkg load statistics');
end
