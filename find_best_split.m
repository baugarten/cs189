
function [ best_feature, best_split ] = find_best_split( data_labels )
%FIND_BEST_SPLIT Summary of this function goes here
%   Detailed explanation goes here
n_datapoints = size(data_labels, 1);
n_features = size(data_labels, 2) - 1;
best_info_gain = 0;
for feature=1:n_features,
    % get a sorted list of unique values
    [feature_values, ia, indices] = unique(data_labels(:, feature));
    num_feature_values = size(feature_values, 1);
    % sum up labels, grouped by feature value
    spam_counts = accumarray(indices, data_labels(:, end));
    total_counts = accumarray(indices, 1);
    cumulative_count = cumsum(total_counts);
    for index=1:num_feature_values,
        count_leq = cumulative_count(index);
        frac_spam_leq = sum(spam_counts(1:index)) ./ count_leq;
        frac_spam_gt = sum(spam_counts(index+1:end)) ./ (n_datapoints - count_leq);
        H_leq = compute_entropy(frac_spam_leq);
        H_gt = compute_entropy(frac_spam_gt);
        info_gain = count_leq .* H_leq + (n_datapoints - count_leq) .* H_gt;
        if info_gain > best_info_gain
            best_info_gain = info_gain;
            best_feature = feature;
            best_split = feature_values(index);
        end
    end
end
end
