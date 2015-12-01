data = load('spamData');
xtrain = data.Xtrain;
ytrain = data.ytrain;
xtest = data.Xtest;
ytest = data.ytest;

size_xtrain = size(xtrain, 1);
xtrain = log(xtrain + repmat(.1, size(xtrain,1), size(xtrain,2)));
xtest = log(xtest + repmat(.1, size(xtest,1), size(xtest,2)));

c = .1
rho = .005;

iters = 100000


count = 0;
for k=1:iters
    point = randi([1 size_xtrain]);
    
    x = xtrain(point,:);
    mu_k = 1 / double(1 + exp(-x*beta + bias));
    
    beta = beta + rho*(ytrain(point) - mu_k)*transpose(x) - rho*2*c*beta;
    bias = bias + rho*(ytrain(point) - mu_k) - rho*2*c*bias;
end
beta
bias
wrongt = 0;
wrongtest = 0;
for k=1:size_xtrain
    answ = 1/(1+exp(-xtrain(k,:)*beta + bias)) > .5;
    if ytrain(k) ~= answ
        wrongt = wrongt + 1;
    end
end
for k=1:size(xtest, 1)
    answ = 1/(1+exp(-xtest(k,:)*beta + bias)) > .5;
    if ytest(k) ~= answ
        wrongtest = wrongtest + 1;
    end
end
wrongt
wrongtest
training_err = wrongt / size_xtrain;
training_err
test_err = wrongtest / size(xtest, 1);
test_err