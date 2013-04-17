function [ xspace, errors ] = plot_tree_entropy_n_nodes( Xtrain, ytrain, Xtest, ytest, min, max )
%PLOT_TREE_ENTROPY_N_NODES Summary of this function goes here
%   Detailed explanation goes here
xspace = min:max;
errors = zeros(size(xspace, 1), 1);
for n=min:max,
    node = build_node_recursive([Xtrain ytrain], 'entropy', 1, 'n_nodes', n);
    errors(n) = evaluate_tree(node, Xtest, ytest);
end
plot(xspace, errors);
xlabel('Minimum number of nodes in leaves')
ylabel('Error Rate')
end

