function crosstuner(min, max, step)

c = min;
maxc = c;
train_file = load('../data/train_small.mat');

train_small = train_file.train;
train1 = train_small{7};
images = double(train1.images);
labels = train1.labels;

maxacc = 0;

while c < max
    model = trains(labels, images, 28, ['-v 10 -c ', num2str(c)]);
    if model > maxacc
        maxacc = model;
        maxc = c;
    end
    c = c + step;
end
maxacc
maxc