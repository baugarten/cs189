function [ depth, nodes ] = tree_stats( root )
%TREE_STATS Summary of this function goes here
%   Detailed explanation goes here
if root.is_leaf
    depth = 1;
    nodes = 1;
else
    [depthl, nodesl] = tree_stats(root.lte);
    [depthr, nodesr] = tree_stats(root.gt);
    depth = max(depthl, depthr) + 1;
    nodes = nodesl + nodesr;
end
end
