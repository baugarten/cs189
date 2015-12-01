function [testlabels, predicted_label, accuracy, decision_values]=trainer(trainerIndex, options)

train_file = load('../data/train_small.mat');

train_small = train_file.train;
train1 = train_small{trainerIndex};
images = double(train1.images);
labels = train1.labels;

model = trains(labels, images, 28, options); %.000001 -B 1000 -s 2');

test_file = load('../data/test.mat');
testimages = double(test_file.test.images);
testlabels = test_file.test.labels;

[predicted_label, accuracy, decision_values] = predict(testlabels, formatter(testimages, 28), model, '');

