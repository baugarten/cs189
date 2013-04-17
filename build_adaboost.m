% Boosting

function [adaboost] = build_adaboost(data_labels, T)
    % initialize
    [n, d] = size(data_labels);
    weights = zeros(1,T);
    classifiers = cell(1,T);
    dist = ones(n, 1)/n;
    depth = 2;
    data = data_labels(:, 1:d-1);
    labels = data_labels(:, end);
    dists = zeros(n,T);
    labels_neg = labels;
    labels_neg(labels == 0) = -1;

    % train weak classifiers
    for t=1:T
        % get stump with error
        stump = build_node_recursive(data_labels, dist, depth); 
        fprintf('Trained stump %d\n', t);
        [weak_error, predictions] = evaluate_tree(stump, data, labels);
        predictions(predictions == 0) = -1;

        % Choose \alpha_t
        weights(t) = 0.5 * (log1p(-weak_error) - log(weak_error));

        % update and normalize
        dists(:, t) = dist;
        dist = dist .* exp(-weights(t) .* labels_neg .* predictions);
        dist = dist ./ sum(dist);

        classifiers{t} = stump;
    end

    adaboost = struct('weights', weights, 'classifiers', {classifiers}, ...
                        'dists', dists);
    disp('Finished adaboost construction');
end
