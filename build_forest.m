function [forest] = build_forest( data_labels, num_trees )
    forest = {};
    dimensions = uint32(5);
    for i=1:num_trees
        indices = randsample(size(data_labels, 1), size(data_labels, 1), true);
        data = data_labels(indices, :);
        tree = build_node_recursively(data, dimensions);
        forest{i} = tree;
    end
end