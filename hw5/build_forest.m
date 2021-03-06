function [forest] = build_forest( data_labels, num_trees, dimensions )
    forest = {};
    if nargin < 3
        dimensions = 20;
    end
    for i=1:num_trees
        indices = randsample(size(data_labels, 1), size(data_labels, 1), true);
        data = data_labels(indices, :);
        tree = build_node_recursive(data, 'entropy', dimensions);
        forest{i} = tree;
    end
end
