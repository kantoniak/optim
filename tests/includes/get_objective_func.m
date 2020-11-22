function [objective] = get_objective_func(name)
% -- [objective] = get_objective_func(name)
%
%     Get definition of objective function by name.

    objective = struct();
    name_equals = @(str) (strcmpi(name, str) == true);

    switch true

        case name_equals('squared_l2_norm')
            objective.func = @squared_l2_norm_func;
            objective.func_name = 'squared_l2_norm';
            objective.display_name = 'Kwadrat normy $ \norm{x}_2 $';
            objective.x0_func = @squared_l2_norm_point;

        case name_equals('penalty_1')
            objective.func = @penalty_1_func;
            objective.func_name = 'penalty_1';
            objective.display_name = 'Funkcja kary I';
            objective.x0_func = @penalty_1_point;

        case name_equals('powell')
            objective.func = @powell_func;
            objective.func_name = 'powell';
            objective.display_name = 'Rozszerzona funkcja Powella';
            objective.x0_func = @powell_point;

        case name_equals('rosenbrock')
            objective.func = @(x) rosenbrock_func(x, 1, 100);
            objective.func_name = 'rosenbrock';
            objective.display_name = 'Rozszerzona funkcja Rosenbrocka';
            objective.x0_func = @rosenbrock_point;

        case name_equals('trigonometric')
            objective.func = @trigonometric_func;
            objective.func_name = 'trigonometric';
            objective.display_name = 'Funkcja trygonometryczna';
            objective.x0_func = @trigonometric_point;

        case name_equals('variably_dimensioned')
            objective.func = @variably_dimensioned_func;
            objective.func_name = 'variably_dimensioned';
            objective.display_name = 'Funkcja z \cite{more1981testing}';
            objective.x0_func = @variably_dimensioned_point;

        case name_equals('fletcher_powell')
            objective.func = @fletcher_powell_func;
            objective.func_name = 'fletcher_powell';
            objective.display_name = 'Dolina spiralna Fletchera i Powella';
            objective.x0_func = @fletcher_powell_point;

        otherwise
            error('xoptim:unknownObjectiveFunc', 'Error.\nUnknown objective function %s', name);
    end

end
