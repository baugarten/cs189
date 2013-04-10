% @author       Ben, Rich, Max
% @assignment   CS189 HW5


% Main function
% @params
%   - data: data points to be split
%   - stopping_opt: stopping criteria
%   - split_opt: splitting criteria
function [] = decision_tree(data, stopping_opt, split_opt)
    [x_train, y_train, x_test, y_test] = loadData(path);
    d_tree = make_tree(x_train, y_train, stopping_opt, split_opt);
    testing_error = test(d_tree, x_test, y_test)
end


% Builds a decision tree
% @params
%   - x: training points
%   - y: training labels
%   - stopping_opt: stopping criteria
%   - split_opt: splitting criteria
% @return
%   d_tree is a struct with two attributes, values and children
function d_tree = make_tree(x, y, stopping_opt, split_opt)
    values = children = [];

    if stopping_opt == 1 and 0, % set threshold
        % sort by all features
        [x_sorted, indices] = sort(x);

        % calculate entropies (or more generally splitting criteria)

        % split on greatest reduction
        x_left = [];
        x_right = [];
        y_left = [];
        y_right = [];

        % decision_tree on both halves
        d_left = make_tree(x_left, y_left, stopping_opt, split_opt);
        d_right = make_tree(x_right, y_right, stopping_opt, split_opt);

        % join together
        values = [values, d_left.values, d_right.values];
        children = [children, d_left.children, d_right.children];
    end

    d_tree = struct('values', values, 'children', children);
end

% Calculates information gain
function i_g = information_gain()
end

% Calculates entropy
function e = entropy()
end
