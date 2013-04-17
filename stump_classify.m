function [class] = stump_classify(stump, feature_vector)
    if feature_vector(stump.dimension) < stump.threshold
        class = stump.left;
    else
        class = stump.right;
    end
end
