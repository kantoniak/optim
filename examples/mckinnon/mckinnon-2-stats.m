% This script generates additional statistics for McKinnon examples.

[entries] = get_mckinnon_example_stats(2, 6, 60, 0);

m = size(entries, 2);
for i = 1:m
    if strcmp(entries(i).state, 'done')
        break;
    end;

    data(i, 1) = entries(i).iter;
    data(i, 2) = entries(i).sgrad_norm;
end

plot(data(:, 1), data(:, 2));
