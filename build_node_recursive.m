function [ node ] = build_node_recursive( data_labels, impurity_method, k, stopping_criteria, stopping_param )
%BUILD_NODE_RECURSIVE Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2
    k = 1;
end
if nargin < 3
    impurity_method = 'entropy';
end
if nargin < 4
    stopping_criteria = 'none';
    stopping_param = 0;
end
    
labels = data_labels(:, end);
if all(labels == labels(1)) || ...
        strcmpi(stopping_criteria, 'n_nodes') && size(labels, 1) < stopping_param
    node = build_leaf(labels);
else
    [feature, split, impurity_reduction] = find_best_split(data_labels, impurity_method, k);
    data_labels = sortrows(data_labels, feature);
    feature_column = data_labels(:, feature);
    index = find(feature_column <= split, 1, 'last');
    lte_data_labels = data_labels(1:index, :);
    gt_data_labels = data_labels(index+1:end, :);
    if 0 == size(gt_data_labels, 1) || ...
            strcmpi(stopping_criteria, 'impurity_reduction') && impurity_reduction < stopping_param
        node = build_leaf(labels);
        return;
    end
    lte_node = build_node_recursive(lte_data_labels, impurity_method, k, stopping_criteria, stopping_param);
    gt_node = build_node_recursive(gt_data_labels, impurity_method, k, stopping_criteria, stopping_param);
    node = build_node(feature, split, lte_node, gt_node);
end
end

function [ node ] = build_node( feature, split, lte_node, gt_node )
    node = struct('is_leaf', false, 'feature', feature, 'split', split, 'lte', lte_node, 'gt', gt_node);
end

function [ node ] = build_leaf( labels )
    label = mode(labels);
    node = struct('is_leaf', true, 'label', label);
end