function [ node ] = build_node_recursive(data_labels, dist, depth)
    labels = data_labels(:, end);

    if depth == 0 || all(labels == labels(1))
        node = build_leaf(labels);
    else
        [feature, split] = find_best_split(data_labels, dist);
        data_labels = sortrows(data_labels, feature);
        feature_column = data_labels(:, feature);
        index = find(feature_column <= split, 1, 'last');
        if index == size(data_labels, 1)
            node = build_leaf(labels);
        else
            lte_data_labels = data_labels(1:index, :);
            lte_node = build_node_recursive(lte_data_labels, dist, depth-1);
            gt_data_labels = data_labels(index+1:end, :);
            gt_node = build_node_recursive(gt_data_labels, dist, depth-1);
            node = build_node(feature, split, lte_node, gt_node);
        end
    end
end

function [ node ] = build_node( feature, split, lte_node, gt_node )
    node = struct('is_leaf', false, 'feature', feature, 'split', split, ...
                  'lte', lte_node, 'gt', gt_node);
end

function [ node ] = build_leaf( labels )
    label = mode(labels);
    node = struct('is_leaf', true, 'label', label);
end
