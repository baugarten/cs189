% @author       Ben, Rich, Max
% @assignment   CS189 HW5


% Main function
% @params
%   - path: path to the data to use
%   - stopping_opt: stopping criteria
%   - split_opt: splitting criteria
% @usage
%   - decision_tree('../data/spamData.mat', @num_points_predicate, @entroy_impurity_strategy)
function [] = decision_tree(path, split_predicate, impurity_strategy)
    [x_train, y_train, x_test, y_test] = loadData(path);
    d_tree = make_tree(x_train, y_train, split_predicate, impurity_strategy);
    testing_error = test(d_tree, x_test, y_test)
end


% Builds a decision tree
% @params
%   - x: training points
%   - y: training labels
%   - split_predcicate: given x and y values at a leaf node, returns true iff this leaf node should be split
%   - impurity_strategy: calculates the impurity of a leaf node given a set of x values and y labels
% @return
%   d_tree is a struct with two attributes, values and children
function d_tree = make_tree(x, y, split_predicate, impurity_strategy)
    values = [];
    children = [];

    if split_predicate(x, y) % if splitting
        % sort by all features
        [x_sorted, indices] = sort(x);

        % calculate entropies (or more generally splitting criteria)
        % can use impurity_strategy as
        % val = impurity_strategy(x_left, y_left)

        % split on greatest reduction
        x_left = [];
        x_right = [];
        y_left = [];
        y_right = [];

        % decision_tree on both halves
        d_left = make_tree(x_left, y_left, split_predicate, impurity_strategy);
        d_right = make_tree(x_right, y_right, split_predicate, impurity_strategy);

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
