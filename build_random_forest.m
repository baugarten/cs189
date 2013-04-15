function [ forest ] = build_random_forest( data_labels, n_trees, k )
%BUILD_RANDOM_FOREST Summary of this function goes here
%   Detailed explanation goes here
forest = {};
for i=1:n_trees
    tree = build_node_recursive(data_labels, k);
    forest{i} = tree;
end
end
