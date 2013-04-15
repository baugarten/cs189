% Boosting

function [adaboost] = build_adaboost(data_labels, T)
    % initialise D
    weights = zeros(1,T);

    % train weak classifiers
    for t=1..T
        
        weights(t) = 0.5 * log((1 - error) / error);
    end

    adaboost = struct('weights', weights, 'classifiers' classifiers);
end
