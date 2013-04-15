function [ error_rate, predictions ] = evaluate_forest( forest, data, labels)
    m = size(labels, 1);
    predictions = zeros(m, 1);
    for j=1:m
        predictions(j) = forest_classify(forest, data(j, :));
    end
    error_rate = sum(predictions ~= labels) ./ m;
end