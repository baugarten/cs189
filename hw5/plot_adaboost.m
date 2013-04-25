load('~/classes/189/hw5/data/spamData.mat');
t_vals = [10 50 100 250 500 750];
errors = zeros(1,6);
for i=1:6
    [adaboost] = build_adaboost([Xtrain ytrain], t_vals(i));
    [error_rate, predictions] = evaluate_adaboost(adaboost, Xtest, ytest);
    errors(i) = error_rate;
end
plot(t_vals, errors);
title('Adaptive Boosting');
xlabel('Number of stumps');
ylabel('Error rate');
