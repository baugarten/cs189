function [ node ] = ...
        build_node_recursive(data_labels, impurity_method, k, ...
                             stopping_criteria, stopping_param, dist, depth)
%BUILD_NODE_RECURSIVE Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        impurity_method = 'entropy';
    end
    if nargin < 3
        k = 1;
    end
    if nargin < 4
        stopping_criteria = 'none';
        stopping_param = 0;
    end
    if nargin < 6
        dist = 0;
        depth = -1;
    end

    labels = data_labels(:, end);
    if depth == 0 || all(labels == labels(1)) || ...
            strcmpi(stopping_criteria, 'n_nodes') && size(labels, 1) < stopping_param
        node = build_leaf(labels, dist);
    else
        [feature, split, impurity_reduction] = ...
            find_best_split(data_labels, impurity_method, k, dist);
        if dist == 0
            data_labels = sortrows([data_labels], feature);
        else
            data_labels = sortrows([data_labels dist], feature);
        end
        feature_column = data_labels(:, feature);
        index = find(feature_column <= split, 1, 'last');
        lte_data_labels = data_labels(1:index, 1:end-1);
        gt_data_labels = data_labels(index+1:end, 1:end-1);
        dist_column = data_labels(:, end);
        if 0 == size(gt_data_labels, 1) || ...
                strcmpi(stopping_criteria, 'impurity_reduction') && ...
                impurity_reduction < stopping_param
            node = build_leaf(labels, dist);
            return;
        end
        if dist == 0
            lte_node = ...
                build_node_recursive(lte_data_labels, impurity_method, k, ...
                                     stopping_criteria, stopping_param, ...
                                     dist, depth);
            gt_node = ...
                build_node_recursive(gt_data_labels, impurity_method, k, ...
                                     stopping_criteria, stopping_param, ...
                                     dist, depth);
        else
            lte_node = ...
                build_node_recursive(lte_data_labels, impurity_method, k, ...
                                     stopping_criteria, stopping_param, ...
                                     dist_column(1:index, :), depth-1);
            gt_node = ...
                build_node_recursive(gt_data_labels, impurity_method, k, ...
                                     stopping_criteria, stopping_param, ...
                                     dist_column(index+1:end, :), depth-1);
        end
        node = build_node(feature, split, lte_node, gt_node);
    end
end

function [ node ] = build_node( feature, split, lte_node, gt_node )
    node = struct('is_leaf', false, 'feature', feature, 'split', split, ...
                  'lte', lte_node, 'gt', gt_node);
end

function [ node ] = build_leaf( labels, dist )
    if dist == 0
        label = mode(labels);
    else
        pos_weight = labels' * dist;
        neg_weight = (~labels)' * dist;
        label = pos_weight > neg_weight;
    end
    node = struct('is_leaf', true, 'label', label);
end
