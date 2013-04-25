function [error_rate, predictions] = evaluate_tree_dist(root, data, labels, dist)
    m = size(labels, 1);
    predictions = zeros(m, 1);
    for j=1:m,
        predictions(j) = tree_classify(root, data(j, :));
    end

    error_rate = sum(dist .* (predictions ~= labels));
end
