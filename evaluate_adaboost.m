function [error_rate, predictions] = evaluate_adaboost(root, data, labels)
    m = size(labels, 1);
    predictions = zeros(m, 1);
    for j=1:m,
        predictions(j) = adaboost_classify(root, data(j, :));
    end
    error_rate = sum(predictions ~= labels) ./ m;
end
