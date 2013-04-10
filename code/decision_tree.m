% @author       Ben, Rich, Max
% @assignment   CS189 HW5

% @params
%   - data: data points to be split
%   - stopping_opt: stopping criteria
%   - split_opt: splitting criteria
function [] = decision_tree(data, stopping_opt, split_opt)
    [x_train, y_train, x_test, y_test] = loadData(path);
    d_tree = make_tree(x_train, y_train, stopping_opt, split_opt);
    testing_error = test(d_tree, x_test, y_test)
end

% @params
%   - x: training points
%   - y: training labels
%   - stopping_opt: stopping criteria
%   - split_opt: splitting criteria
% @return
%   d_tree is a struct with two attributes, values and parents
function d_tree = make_tree(x, y, stopping_opt, split_opt)
    % if stopping criteria not met
        % sort all by all features
        % calculate entropies (or more generally splitting criteria)
        % split on greatest reduction
        % decision_tree on both halves
end
