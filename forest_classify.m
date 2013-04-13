function label = forest_classify(forest, data_point)
    num_trees = size(forest, 2);
    num_spam = 0;
    for i=1:num_trees,
        cur_tree = forest{i};
        if tree_classify(cur_tree, data_point) == 1
            num_spam = num_spam + 1;
        end
    end

    % take majority vote
    label =  round(num_pos / num_trees);
end