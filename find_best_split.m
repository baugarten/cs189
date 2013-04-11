function [ best_feature, best_split ] = find_best_split( data_labels )
%FIND_BEST_SPLIT Summary of this function goes here
%   Detailed explanation goes here
n_datapoints = size(data_labels, 1);
n_features = size(data_labels, 2) - 1;
best_info_gain = 0;
for feature=1:n_features,
    sorted = sortrows(data_labels, feature);
    for split=1:n_datapoints,
        frac_spam_lt = sum(sorted(1:split-1, end)) ./ split;
        frac_spam_geq = sum(sorted(split:end, end)) ./ (n_datapoints - split);
        H_lt = compute_entropy(frac_spam_lt);
        H_geq = compute_entropy(frac_spam_geq);
        info_gain = split .* H_lt + (n_datapoints - split) .* H_geq;
        if info_gain > best_info_gain
            best_info_gain = info_gain;
            best_feature = feature;
            best_split = sorted(split, feature);
        end
    end
end
end
