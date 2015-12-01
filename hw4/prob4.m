data = load('spamData');
xtrain = data.Xtrain;
ytrain = data.ytrain;
xtest = data.Xtest;
ytest = data.ytest;

size_xtrain = size(xtrain, 1);
xtrain = log(xtrain + repmat(.1, size(xtrain,1), size(xtrain,2)));
size_xtrain
size(xtrain)
data = zeros(size_xtrain/5, size(xtrain, 2), 5);
data(:,:,1) = xtrain(1:size_xtrain/5,:);
data(:,:,2) = xtrain(size_xtrain/5+1:2*size_xtrain/5,:);

data(:,:,3) = xtrain(2*size_xtrain/5+1:3*size_xtrain/5,:);
data(:,:,4) = xtrain(3*size_xtrain/5+1:4*size_xtrain/5,:);
data(:,:,5) = xtrain(4*size_xtrain/5+1:size_xtrain,:);
tmp = 100;
cs = [tmp]
while tmp > .0000000000001
    tmp = tmp / 10;
    cs = [cs ; tmp];
end
rho = .005;

iters = 5000

wrong = [];
for c=1:length(cs)
    c = cs(c)
    wrongt = 0;
    count = 0;
    for i=1:5
        beta = zeros(size(xtrain, 2), 1);
        bias = 0;
        for k=1:iters
            if i == 1
                point = randi([size_xtrain/5+1 size_xtrain]);
            elseif i == 2
                point1 = randi([1 size_xtrain/5]);
                point2 = randi([2*size_xtrain/5+1 size_xtrain]);
                if rand(1) > .25
                    point = point2;
                else
                    point = point1;
                end
            elseif i == 3
                point1 = randi([1 2*size_xtrain/5]);
                point2 = randi([3*size_xtrain/5+1 size_xtrain]);
                if rand(1) > .5
                    point = point2;
                else
                    point = point1;
                end
            elseif i == 4
                point1 = randi([1 3*size_xtrain/5]);
                point2 = randi([4*size_xtrain/5+1 size_xtrain]);
                if rand(1) > .75
                    point = point2;
                else
                    point = point1;
                end
            elseif i == 5
                point = randi([1 4*size_xtrain/5]);
            end
           
            x = xtrain(point,:);
            mu_k = 1 / double(1 + exp(-x*beta + bias));
            
            beta = beta + rho*(ytrain(point) - mu_k)*transpose(x) - rho*2*c*beta;
            bias = bias + rho*(ytrain(point) - mu_k) - rho*2*c*bias;
        end
        beta
        bias
        for k=(i-1)*size_xtrain/5+1:i*size_xtrain/5
            answ = 1/(1+exp(-xtrain(k,:)*beta + bias)) > .5;
            if ytrain(k) ~= answ
                wrongt = wrongt + 1;
            end
            count = count + 1;
        end
    end
    count
    wrongt
    wrong = [wrong ; wrongt/(4*size_xtrain/5)];
end
wrong
semilogx(cs, wrong);