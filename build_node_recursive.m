function [ node ] = build_node_recursive(data_labels, dist, depth)
    labels = data_labels(:, end);

    if depth == 0
        node = build_leaf(labels, dist);
    else
        [feature, split] = find_best_split(data_labels, dist);
        data_labels = sortrows([data_labels dist], feature);
        feature_column = data_labels(:, feature);
        dist_column = data_labels(:, end);
        index = find(feature_column <= split, 1, 'last');
        if index == size(data_labels, 1)
            node = build_leaf(labels, dist);
        else
            lte_data_labels = data_labels(1:index, 1:end-1);
            lte_node = build_node_recursive(lte_data_labels, dist_column(1:index, :), depth-1);
            gt_data_labels = data_labels(index+1:end, 1:end-1);
            gt_node = build_node_recursive(gt_data_labels, dist_column(index+1:end, :), depth-1);
            node = build_node(feature, split, lte_node, gt_node);
        end
    end
end

function [ node ] = build_node( feature, split, lte_node, gt_node )
    node = struct('is_leaf', false, 'feature', feature, 'split', split, ...
                  'lte', lte_node, 'gt', gt_node);
end

function [ node ] = build_leaf( labels, dist )
    %label = mode(labels);
    pos_weight = labels' * dist;
    neg_weight = (~labels)' * dist;
    label = pos_weight > neg_weight;
    node = struct('is_leaf', true, 'label', label);
end
