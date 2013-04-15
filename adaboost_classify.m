% Adaboost classifying

% Calculates H(x) = sign(\sum_{t=1}^{T} \alpha_t h_t(x))
function [class] = adaboost_classify(adaboost, feature_vector)
    weights = adaboost.weights;
    classifiers = adaboost.classifiers;
    T = size(classifiers, 2);

    accum = 0;
    for t=1..T
        cur_tree = classifiers(i);
        accum = accum + weights(t) * tree_classify(cur_tree, feature_vector);
    end

    class = sign(accum);
end
