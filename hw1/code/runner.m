function [errrates, num_training, confmats] =runner(c, B, s, v)
%c = num2str(1.0000e-06);
%B = '1000';
%s = '2';
opts = '';
if ~isempty(c)
    opts = [opts, ' -c ', num2str(c)];
end
if ~isempty(B)
    opts = [opts, ' -B ', num2str(B)];
end
if ~isempty(s)
    opts = [opts, ' -s ', num2str(s)];
end
if ~isempty(v)
    opts = [opts, ' -v ', num2str(v)];
end
c = num2str(3.9e-7);
B = '-1'
s = '1'
v = false;

accuracies = zeros(7, 3);
errrates = zeros(7);
confmats = zeros(10,10, 7);
num_training = [100,200,500,1000,2000,5000,10000];
for i=1:7
    [truelabels, predlabels, accuracies(i,:), decision_values] = trainer(i, opts);
    errrates(i) = benchmark(predlabels, truelabels);
    [confmats(:,:,i), order] = confusionmat(truelabels, predlabels);
    opts
end