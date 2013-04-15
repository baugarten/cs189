% Boosting

function [adaboost] = build_adaboost(data_labels, T)
    % initialize
    [n, d] = size(data_labels);
    weights = zeros(1,T);
    classifiers = {};
    dist = ones(1,T)/T;
    depth = 1;
    data = data_labels(:, 1:n-1);
    labels = data_labels(:, end);

    % train weak classifiers
    for t=1:T
        % get stump with error
        [stump] = build_node_recursive(data_labels, dist, depth); 
        [weak_error, predictions] = evaulate_tree(stump, data, labels);
        misclassifications = predictions ~= labels;
        correct = predictions == labels;

        % Choose \alpha_t
        weights(t) = 0.5 * log((1 - weak_error) / weak_error);

        % update and normalize
        reweight = misclassifications .* exp(weights) + correct .* exp(-weights);
        dist = dist .* reweight;
        dist = dist / sum(dist)

        classifiers{t} = stump;
    end

    adaboost = struct('weights', weights, 'classifiers' classifiers);
end
