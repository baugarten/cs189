% Boosting

function [adaboost] = build_adaboost(data_labels, T)
    % initialize
    [n, d] = size(data_labels);
    weights = zeros(1,T);
    classifiers = cell(1,T);
    dist = ones(n, 1)/n;
    depth = 1;
    data = data_labels(:, 1:d-1);
    labels = data_labels(:, end);

    % train weak classifiers
    for t=1:T
        fprintf('Training stump %d\n', t);
        % get stump with error
        [stump] = build_node_recursive(data_labels, dist, depth); 
        [weak_error, predictions] = evaluate_tree(stump, data, labels);
        misclassifications = predictions ~= labels;
        correct = predictions == labels;

        % Choose \alpha_t
        weights(t) = 0.5 * log((1 - weak_error) / weak_error);

        % update and normalize
        alpha_weight = ones(n, 1) * weights(t);
        reweight = misclassifications .* exp(alpha_weight) + ...
                correct .* exp(-alpha_weight);
        dist = dist .* reweight;
        dist = dist ./ sum(dist);

        classifiers{t} = stump;
    end

    adaboost = struct('weights', weights, 'classifiers', {classifiers});
    disp('Finished adaboost construction');
end
