function [ errors ] = plot_forest_2_error_vs_trees( Xtrain, ytrain, Xtest, ytest, xspace )
%PLOT_FOREST_2_ERROR_VS_TREES Summary of this function goes here
%   Detailed explanation goes here
n_samples = numel(xspace);
errors = zeros(n_samples, 1);
for j=1:n_samples,
    n = xspace(j);
    node = build_random_forest_kbest([Xtrain ytrain], n, n);
    errors(j) = evaluate_forest(node, Xtest, ytest);
end
plot(xspace, errors);
xlabel('Number of Trees and K')
ylabel('Error Rate')

end

