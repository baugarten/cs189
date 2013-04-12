function [ best_feature, best_split ] = find_best_split( data_labels )
%FIND_BEST_SPLIT Summary of this function goes here
%   Detailed explanation goes here
n_datapoints = size(data_labels, 1);
n_features = size(data_labels, 2) - 1;
min_entropy = Inf;
for feature=1:n_features,
    feature_vect = data_labels(:, feature);
    % get a sorted list of unique values
    [feature_values, ia, indices] = unique(feature_vect);
    % sum up labels, grouped by feature value
    spam_counts = accumarray(indices, data_labels(:, end));
    total_counts = accumarray(indices, 1);
    % get counts for <= and >
    count_lte = cumsum(total_counts);
    count_geq = rcumsum(total_counts);
    % do a cumulative sum from both the bottom and top to get the
    % percentage of messages classified as spam on either side of the value
    frac_spam_lte = cumsum(spam_counts) ./ count_lte;
    frac_spam_geq = rcumsum(spam_counts) ./ count_geq;
    entropy_lte = compute_entropy(frac_spam_lte);
    entropy_geq = compute_entropy(frac_spam_geq);
    entropy_gt = shiftl(entropy_geq, 1);
    count_gt = shiftl(count_geq, 1);
    % compute the information gains.
    new_entropy = count_lte .* entropy_lte + count_gt .* entropy_gt;
    [current_min_entropy, index] = min(new_entropy);
    if current_min_entropy < min_entropy
        min_entropy = current_min_entropy;
        best_feature = feature;
        best_split = feature_values(index);
    end
end
end

function [ result ] = rcumsum( vector )
result = flipud(cumsum(flipud(vector)));
end

function [ shifted ] = shiftl( vector, amount )
shifted = circshift(vector, -amount);
shifted(1+size(vector, 1)-amount:end) = 0;
end