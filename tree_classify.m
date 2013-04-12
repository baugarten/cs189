function [ class ] = tree_classify( root, feature_vector )
%TREE_CLASSIFY Summary of this function goes here
%   Detailed explanation goes here
if root.is_leaf
    class = root.label;
else
    if feature_vector(root.feature) <= root.split
        class = tree_classify(root.lte, feature_vector);
    else
        class = tree_classify(root.gt, feature_vector);
    end
end
end
