% Adaboost classifying

% Calculates H(x) = sign(\sum_{t=1}^{T} \alpha_t h_t(x))
function [class] = adaboost_classify(adaboost, feature_vector)
    weights = adaboost.weights;
    classifiers = adaboost.classifiers;
    T = size(classifiers, 2);

    accum = 0;
    for t=1:T
        cur_stump = classifiers{t};

        if tree_classify(cur_stump, feature_vector) == 0
            h_t = -1;
        else
            h_t = 1;
        end

        accum = accum + weights(t) * h_t;
    end

    class = accum > 0;
end
