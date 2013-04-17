function stump = build_stump(data_labels, dist)
    [n, d] = size(data_labels);
    d = d - 1;
    data = data_labels(:, 1:d);
    labels = data_labels(:, end);

    [sorted_data, indices] = sort(data);
    sorted_labels = labels(indices);
    sorted_dist = dist(indices);

    predictions = zeros(n,1);

    min_err = Inf;
    split_dim = 0;
    thresh_ind = 0;
    left = -1;
    right = -1;

    break_flag = -1;

    % find split with lowest error
    for dim=1:d
        cur_labels = sorted_labels(:, dim);
        cur_dist = sorted_dist(:, dim);
        cur_dist_sum = sum(cur_dist);
        for pivot=1:n
            l_miss = [zeros(pivot, 1); ones(n - pivot, 1)] ~= cur_labels;
            l_err = (l_miss' * cur_dist) / cur_dist_sum;

            r_miss = [ones(pivot, 1); zeros(n - pivot, 1)] ~= cur_labels;
            r_err = (r_miss' * cur_dist) / cur_dist_sum;

            %if l_err < 0.5
            %    split_dim = dim;
            %    thresh_ind = pivot;
            %    left = 0;
            %    right = 1;
            %    break_flag = 1;
            %    break;
            %end
            %if r_err < 0.5
            %    split_dim = dim;
            %    thresh_ind = pivot;
            %    left = 1;
            %    right = 0;
            %    break_flag = 1;
            %    break;
            %end

            if l_err < min_err
                min_err = l_err;
                split_dim = dim;
                thresh_ind = pivot;
                left = 0;
                right = 1;
            end
            if r_err < min_err
                min_err = r_err;
                split_dim = dim;
                thresh_ind = pivot;
                left = 1;
                right = 0;
            end
        end
        if break_flag == 1
            break;
        end
    end

    threshold = sorted_data(pivot, dim);
    stump = struct('dimension', split_dim, 'threshold', threshold, ...
                   'left', left, 'right', right);
end
