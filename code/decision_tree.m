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
        num_points = size(x_sorted, 1);
        max_delta_impurity = -1;
        best_split = -1;
        for i=1:size(x_sorted, 2) % each dimension
          for j=1:(num_points - 1) % each row except the last
            split_value = (x_sorted(j, i) + x_sorted(j+1, i)) / 2;
            P_l = (j / num_points);

            x_left = x(indices(1:j,i),:); % does this work? I think so
            x_right = x(indices(j+1:num_points,i),:);
            y_left = y(indices(1:j,i),:);
            y_right = y(indices(j+1:num_points,i),:);

            delta_impurity = - P_l * impurity_strategy(x_left, y_left) - ...
                             (1 - P_l) * impurity_strategy(x_right, y_right);
            if isnan(delta_impurity)
                delta_impurity = 0;
            end
            if (delta_impurity > max_delta_impurity)
              max_delta_impurity = delta_impurity;
              best_split = split_value; % We have to keep track of this value
              best_x_left = x_left;
              best_x_right = x_right;
              best_y_left = y_left;
              best_y_right = y_right;
            end
          end
        end
        disp('Best split');
        best_split
        max_delta_impurity
        size(x_sorted, 2)
        num_points
        size(best_x_left)
        size(best_x_right)
        size(best_y_left)
        size(best_y_right)
        % decision_tree on both halves
        d_left = make_tree(best_x_left, best_y_left, split_predicate, impurity_strategy);
        d_right = make_tree(best_x_right,  best_y_right, split_predicate, impurity_strategy);

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
