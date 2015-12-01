data = load('spamData');
xtrain = data.Xtrain;
ytrain = data.ytrain;
xtest = data.Xtest;
ytest = data.ytest;
iters = [1000, 5000, 10000, 20000, 50000, 100000, 1000000, 10000000];

betas21 = zeros(size(xtrain, 2),1, length(iters));
betas22 = zeros(size(xtrain, 2),1, length(iters));
betas23 = zeros(size(xtrain, 2),1, length(iters));
rho = .1;
c = .0001;

xtrain1_norm = zscore(xtrain);
xtrain2_norm = log(xtrain + repmat(.1, size(xtrain,1), size(xtrain,2)));
xtrain3_norm = xtrain > 0;

xtest1_norm = zscore(xtest);
xtest2_norm = log(xtest + repmat(.1, size(xtest,1), size(xtest,2)));
xtest3_norm = xtest > 0;

bias1 = zeros(length(iters), 1);
bias2 = zeros(length(iters), 1);
bias3 = zeros(length(iters), 1);

count = 1;
size_xtrain = uint64(size(xtrain, 1));

for j = 1:length(iters)
    beta1 = betas21(:,:,j);
    beta2 = betas22(:,:,j);
    beta3 = betas23(:,:,j);
    for k=1:iters(j)
        rho = .1 / k;
        point = round(rand(1)*size_xtrain)+1;
        point = uint64(point);
        x1 = xtrain1_norm(mod(point-1, size_xtrain)+1,:);
        x2 = xtrain2_norm(mod(point-1, size_xtrain)+1,:);
        x3 = xtrain3_norm(mod(point-1, size_xtrain)+1,:);
        
        mu1_k = 1 / double(1 + exp(-x1*beta1 + bias1(j,:)));
        mu2_k = 1 / double(1 + exp(-x2*beta2 + bias2(j,:)));
        mu3_k = 1 / double(1 + exp(-x3*beta3 + bias3(j,:)));

        beta1 = beta1 + rho*(ytrain(mod(point-1, size_xtrain)+1) - mu1_k)*transpose(x1) - rho*2*c*beta1;
        beta2 = beta2 + rho*(ytrain(mod(point-1, size_xtrain)+1) - mu2_k)*transpose(x2) - rho*2*c*beta2;
        beta3 = beta3 + rho*(ytrain(mod(point-1, size_xtrain)+1) - mu3_k)*transpose(x3) - rho*2*c*beta3;
                
        bias1(j,:) = bias1(j,:) + rho*(ytrain(mod(point-1, size_xtrain)+1) - mu1_k) - rho*2*c*bias1(j,:);
        bias2(j,:) = bias2(j,:) + rho*(ytrain(mod(point-1, size_xtrain)+1) - mu2_k) - rho*2*c*bias2(j,:);
        bias3(j,:) = bias3(j,:) + rho*(ytrain(mod(point-1, size_xtrain)+1) - mu3_k) - rho*2*c*bias3(j,:);
    end
    betas21(:,:,j) = beta1;
    betas22(:,:,j) = beta2;
    betas23(:,:,j) = beta3;
    count = count + 1;
end
loss1 = zeros(length(iters), 1);
loss2 = zeros(length(iters), 1);
loss3 = zeros(length(iters), 1);
xtest_norm = zscore(xtest);
for point=1:length(iters)
    beta1 = betas21(:,:,point);
    beta2 = betas22(:,:,point);
    beta3 = betas23(:,:,point);
    for i=1:size(xtrain1_norm, 1)
        if (ytrain(i) == 1) 
            loss1(point,:) = loss1(point,:) - (-log1p(exp(-xtrain1_norm(i,:)*beta1 + bias1(point,:))));
            loss2(point,:) = loss2(point,:) - (-log1p(exp(-xtrain2_norm(i,:)*beta2 + bias2(point,:))));
            loss3(point,:) = loss3(point,:) - (-log1p(exp(-xtrain3_norm(i,:)*beta3 + bias3(point,:))));
        else
            loss1(point,:) = loss1(point,:) - (-log1p(exp(xtrain1_norm(i,:)*beta1 - bias1(point,:))));
            loss2(point,:) = loss2(point,:) - (-log1p(exp(xtrain2_norm(i,:)*beta2 - bias2(point,:))));
            loss3(point,:) = loss3(point,:) - (-log1p(exp(xtrain3_norm(i,:)*beta3 - bias3(point,:))));
        end
    end
    loss1(point,:) = loss1(point,:) + c*transpose(beta1)*beta1;
    loss2(point,:) = loss2(point,:) + c*transpose(beta2)*beta2;
    loss3(point,:) = loss3(point,:) + c*transpose(beta3)*beta3;
end
wrong1 = zeros(length(iters), 1);
wrong2 = zeros(length(iters), 1);
wrong3 = zeros(length(iters), 1);
for point=1:length(iters)
    beta1 = betas21(:,:,point);
    beta2 = betas22(:,:,point);
    beta3 = betas23(:,:,point);
    for i=1:size(xtrain, 1)
        answ1 = 1/(1+exp(-xtrain1_norm(i,:)*beta1 + bias1(point,:))) > .5;
        if ytrain(i) ~= answ1
            wrong1(point,:) = wrong1(point,:) + 1;
        end
        answ2 = 1/(1+exp(-xtrain2_norm(i,:)*beta2 + bias2(point,:))) > .5;
        if (ytrain(i) ~= answ2)
            wrong2(point,:) = wrong2(point,:) + 1;
        end
        answ3 = 1/(1+exp(-xtrain3_norm(i,:)*beta3 + bias3(point,:))) > .5;
        if (ytrain(i) ~= answ3)
            wrong3(point,:) = wrong3(point,:) + 1;
        end
    end
end


wrongt1 = zeros(length(iters), 1);
wrongt2 = zeros(length(iters), 1);
wrongt3 = zeros(length(iters), 1);
for point=1:length(iters)
    beta1 = betas21(:,:,point);
    beta2 = betas22(:,:,point);
    beta3 = betas23(:,:,point);
    for i=1:size(xtest, 1)
        answ1 = 1/(1+exp(-xtest1_norm(i,:)*beta1 + bias1(point,:))) > .5;
        if ytest(i) ~= answ1
            wrongt1(point,:) = wrongt1(point,:) + 1;
        end
        answ2 = 1/(1+exp(-xtest2_norm(i,:)*beta2 + bias2(point,:))) > .5;
        if (ytest(i) ~= answ2)
            wrongt2(point,:) = wrongt2(point,:) + 1;
        end
        answ3 = 1/(1+exp(-xtest3_norm(i,:)*beta3 + bias3(point,:))) > .5;
        if (ytest(i) ~= answ3)
            wrongt3(point,:) = wrongt3(point,:) + 1;
        end
    end
end

semilogx(iters, loss1);
figure
semilogx(iters, loss2);
figure;
semilogx(iters, loss3);
figure
semilogx(iters, loss1);
hold all;
semilogx(iters, loss2);
hold all;
semilogx(iters, loss3);
loss1
loss2
loss3
wrong1 = wrong1 ./ size(xtrain, 1);
wrong2 = wrong2 ./ size(xtrain, 1);
wrong3 = wrong3 ./ size(xtrain, 1);
wrongt1 = wrongt1 ./ size(xtest, 1);
wrongt2 = wrongt2 ./ size(xtest, 1);
wrongt3 = wrongt3 ./ size(xtest, 1);
wrong1
wrong2
wrong3
wrongt1
wrongt2
wrongt3
size(xtrain, 1)
