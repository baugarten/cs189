% too slow

function stump = build_stump(data_labels, dist)
    [n, d] = size(data_labels);
    d = d - 1;
    data = data_labels(:, 1:d);
    labels = data_labels(:, end);

    stumps = cell(1, d);
    errors = zeros(1, d);
    for i=1:d
        stumps{i} = make_1d_stump(data(:, i), labels, i, dist);
        errors = stumps{i}.err;
    end

    [min_v, min_i] = min(errors);
    stump = stumps{min_i};
end

function stump = make_1d_stump(x, y, d, dist)
    n = size(x,1);
    errors_less = zeros(1, n);
    errors_greater = zeros(1, n);
    predictions = zeros(n, 1);

    for i=1:n
        greater_i = x >= x(i);
        predictions(greater_i) = 1;
        predictions(~greater_i) = 0;
        greater_err = predictions ~= y;
        errors_greater(i) = dist' * greater_err / sum(dist);

        less_i = x < x(i);
        predictions(less_i) = 1;
        predictions(~less_i) = 0;
        less_err = predictions ~= y;
        errors_less(i) = dist' * less_err / sum(dist);
    end

    [v_g, i_g] = min(errors_greater);
    [v_l, i_l] = min(errors_less);
    if i_g < i_l
        err = v_g;
        threshold = x(i_g);
        left = 0;
        right = 1;
    else
        err = v_l;
        threshold = x(i_l);
        left = 1;
        right = 0;
    end

    stump = struct('dimension', d, 'threshold', threshold, 'err', err, ...
                   'left', left, 'right', right);
end
