function [error_rate, predictions] = evaluate_stump(stump, data, labels)
    m = size(labels, 1);
    predictions = zeros(m, 1);
    for j=1:m,
        predictions(j) = stump_classify(stump, data(j, :));
    end
    error_rate = sum(predictions ~= labels) / m;
end
