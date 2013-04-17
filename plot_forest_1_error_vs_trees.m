function [ errors ] = plot_forest_1_error_vs_trees( Xtrain, ytrain, Xtest, ytest, xspace )
%PLOT_FOREST_1_ERROR_VS_TREES Summary of this function goes here
%   Detailed explanation goes here
n_samples = numel(xspace);
errors = zeros(n_samples, 1);
for j=1:n_samples,
    n = xspace(j);
    node = build_random_forest([Xtrain ytrain], n, 5);
    errors(j) = evaluate_forest(node, Xtest, ytest);
end
plot(xspace, errors);
xlabel('Number of Trees')
ylabel('Error Rate')

end

