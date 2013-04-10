% @author       Richard Hwang
% @assignment   CS189 HW4

% Loads data
function [x_training, y_training, x_test, y_test] = loadData(path)
    spamData = open(path);
    x_training = spamData.Xtrain;
    y_training = spamData.ytrain;
    x_test = spamData.Xtest;
    y_test = spamData.ytest;
    disp('Data loaded.');
end
