function [ best_feature, best_split, impurity_reduction ] = find_best_split( data_labels, impurity_method, k )
%FIND_BEST_SPLIT Summary of this function goes here
%   Detailed explanation goes here
n_datapoints = size(data_labels, 1);
n_features = size(data_labels, 2) - 1;
if k > 1
  features = randsample(n_features, k);
  n_features = k;
  k = 1;
else
  features = 1:n_features;
end
k_best = zeros(k, 3);
k_best(:, 1) = Inf;
index_worst = 1;
labels = data_labels(:, end);
old_entropy = compute_entropy(sum(labels) ./ n_datapoints, impurity_method);
for i=1:n_features,
    feature = features(i);
    feature_vect = data_labels(:, feature);
    % get a sorted list of unique values
    [feature_values, ~, indices] = unique(feature_vect);
    % sum up labels, grouped by feature value
    spam_counts = accumarray(indices, labels);
    total_counts = accumarray(indices, 1);
    % get counts for <= and >
    count_lte = cumsum(total_counts);
    count_geq = rcumsum(total_counts);
    % do a cumulative sum from both the bottom and top to get the
    % percentage of messages classified as spam on either side of the value
    frac_spam_lte = cumsum(spam_counts) ./ count_lte;
    frac_spam_geq = rcumsum(spam_counts) ./ count_geq;
    entropy_lte = compute_entropy(frac_spam_lte, impurity_method);
    entropy_geq = compute_entropy(frac_spam_geq, impurity_method);
    entropy_gt = shiftl(entropy_geq, 1);
    count_gt = shiftl(count_geq, 1);
    % compute the information gains.
    new_entropy = count_lte .* entropy_lte + count_gt .* entropy_gt;
    % update the k_best array.
    for index=1:size(new_entropy, 1),
        if new_entropy(index) < k_best(index_worst, 1)
            k_best(index_worst, :) = [new_entropy(index), feature, feature_values(index)];
            [~, index_worst] = max(k_best(:, 1));
        end
    end
end
rand_index = randi(k, 1);
chosen = k_best(rand_index, :);
new_entropy = chosen(1);
best_feature = chosen(2);
best_split = chosen(3);
impurity_reduction = (old_entropy - new_entropy) ./ old_entropy;
end

function [ result ] = rcumsum( vector )
result = flipud(cumsum(flipud(vector)));
end

function [ shifted ] = shiftl( vector, amount )
shifted = circshift(vector, -amount);
shifted(1+size(vector, 1)-amount:end) = 0;
end
