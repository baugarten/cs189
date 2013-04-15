function [ forest ] = build_random_forest( data_labels, n_trees, k, impurity_method )
%BUILD_RANDOM_FOREST Summary of this function goes here
%   Detailed explanation goes here
if nargin < 4
    impurity_method = 'entropy';
end
forest = {};
for i=1:n_trees
    tree = build_node_recursive(data_labels, impurity_method, k);
    forest{i} = tree;
end
end
