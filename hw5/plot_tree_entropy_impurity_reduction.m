function [ errors ] = plot_tree_entropy_impurity_reduction( Xtrain, ytrain, Xtest, ytest, xspace )
%PLOT_TREE_ENTROPY_IMPURITY_REDUCTION Summary of this function goes here
%   Detailed explanation goes here
n_samples = numel(xspace);
errors = zeros(n_samples, 1);
for j=1:n_samples,
    n = xspace(j);
    node = build_node_recursive([Xtrain ytrain], 'entropy', 1, 'impurity_reduction', n);
    errors(j) = evaluate_tree(node, Xtest, ytest);
end
plot(xspace, errors);
xlabel('Impurity Reduction Cutoff')
ylabel('Error Rate')
end

