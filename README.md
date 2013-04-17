## Usage

```
load('matlab');
tree = build_node_recursive([Xtrain ytrain]); % using entropy impurity
tree = build_node_recursive([Xtrain ytrain], 'variance'); % using entropy impurity
tree = build_node_recursive([Xtrain ytrain], 'misclassification', 10); % and randomly pick 10 features to split on

forest = build_random_forest([Xtrain ytrain], 100, 10); % forest of 100 trees, randomly picking 10 features to split on
forest = build_random_forest([Xtrain ytrain], 100, 10, 'misclassification'); % Using the misclassification impurity calculator

adaboost = build_adaboost([Xtrain ytrain], 750); % 750 boosted stumps

err_rate = evaluate_tree(tree, Xtest, ytest);
err_rate = evaluate_forest(forest, Xtest, ytest);
err_rate = evaluate_adaboost(adaboost, Xtest, ytest);
```
