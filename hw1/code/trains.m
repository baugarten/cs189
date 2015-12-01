function [model]=trains(labels, images, dim, options)
addpath('liblinear-1.92/matlab');
model = train(labels, formatter(images, dim), options);