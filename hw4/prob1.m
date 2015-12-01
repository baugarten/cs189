data = load('spamData');
xtrain = data.Xtrain;
ytrain = data.ytrain;
xtest = data.Xtest;
ytest = data.ytest;
iters = [1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 5000, 10000];

betas1 = zeros(size(xtrain, 2),1, length(iters));
betas2 = zeros(size(xtrain, 2),1, length(iters));
betas3 = zeros(size(xtrain, 2),1, length(iters));
rho = .00000015;
c = .15;

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
for j = iters
    j
    beta1 = betas1(:,:,count);
    beta2 = betas2(:,:,count);
    beta3 = betas3(:,:,count);
    for k=1:j
        update1 = 0;
        update2 = 0;
        update3 = 0;
        
        upb1 = 0;
        upb2 = 0;
        upb3 = 0;
        for i=1:size(xtrain, 1)
            mu1_i = 1 / double(1 + exp(-xtrain1_norm(i,:)*beta1 + bias1(count,:)));
            update1 = update1 + (ytrain(i) - mu1_i)*transpose(xtrain1_norm(i,:));
            upb1 = upb1 + (ytrain(i) - mu1_i);
            
            mu2_i = 1 / double(1 + exp(-xtrain2_norm(i,:)*beta2 + bias2(count,:)));
            update2 = update2 + (ytrain(i) - mu2_i)*transpose(xtrain2_norm(i,:));
            upb2 = upb2 + (ytrain(i) - mu2_i);
            
            mu3_i = 1 / double(1 + exp(-xtrain3_norm(i,:)*beta3 + bias3(count,:)));
            update3 = update3 + (ytrain(i) - mu3_i)*transpose(xtrain3_norm(i,:));
            upb3 = upb3 + (ytrain(i) - mu3_i);
        end
        beta1 = beta1 + rho*update1 - rho*2*c*beta1;
        beta2 = beta2 + rho*update2 - rho*2*c*beta2;
        beta3 = beta3 + rho*update3 - rho*2*c*beta3;
        
        bias1(count,:) = bias1(count,:) + rho*upb1 - rho*2*c*bias1(count,:);
        bias2(count,:) = bias2(count,:) + rho*upb2 - rho*2*c*bias2(count,:);
        bias3(count,:) = bias3(count,:) + rho*upb3 - rho*2*c*bias3(count,:);
    end
    betas1(:,:,count) = beta1;
    betas2(:,:,count) = beta2;
    betas3(:,:,count) = beta3;
    count = count + 1;
end
loss1 = zeros(length(iters), 1);
loss2 = zeros(length(iters), 1);
loss3 = zeros(length(iters), 1);
betas1(:,:,1)
betas1(:,:,5)
bias1(1,:)
bias1(6,:)
bias1(7,:)
for k=1:length(iters)
    beta1 = betas1(:,:,k);
    beta2 = betas2(:,:,k);
    beta3 = betas3(:,:,k);
    for i=1:size(xtrain1_norm, 1)
        if (ytrain(i) == 1) 
            loss1(k,:) = loss1(k,:) - (-log1p(exp(-xtrain1_norm(i,:)*beta1 + bias1(k,:))));
            loss2(k,:) = loss2(k,:) - (-log1p(exp(-xtrain2_norm(i,:)*beta2 + bias2(k,:))));
            loss3(k,:) = loss3(k,:) - (-log1p(exp(-xtrain3_norm(i,:)*beta3 + bias3(k,:))));
        else
            loss1(k,:) = loss1(k,:) - (-log1p(exp(xtrain1_norm(i,:)*beta1 - bias1(k,:))));
            loss2(k,:) = loss2(k,:) - (-log1p(exp(xtrain2_norm(i,:)*beta2 - bias2(k,:))));
            loss3(k,:) = loss3(k,:) - (-log1p(exp(xtrain3_norm(i,:)*beta3 - bias3(k,:))));
        end
    end
    loss1(k,:) = loss1(k,:) + c*transpose(beta1)*beta1;
    loss2(k,:) = loss2(k,:) + c*transpose(beta2)*beta2;
    loss3(k,:) = loss3(k,:) + c*transpose(beta3)*beta3;
end
wrong1 = zeros(length(iters), 1);
wrong2 = zeros(length(iters), 1);
wrong3 = zeros(length(iters), 1);
for k=1:length(iters)
    beta1 = betas1(:,:,k);
    beta2 = betas2(:,:,k);
    beta3 = betas3(:,:,k);
    for i=1:size(xtrain, 1)
        answ1 = 1/(1+exp(-xtrain1_norm(i,:)*beta1 + bias1(k,:))) > .5;
        if ytrain(i) ~= answ1
            wrong1(k,:) = wrong1(k,:) + 1;
        end
        answ2 = 1/(1+exp(-xtrain2_norm(i,:)*beta2 + bias2(k,:))) > .5;
        if (ytrain(i) ~= answ2)
            wrong2(k,:) = wrong2(k,:) + 1;
        end
        answ3 = 1/(1+exp(-xtrain3_norm(i,:)*beta3 + bias3(k,:))) > .5;
        if (ytrain(i) ~= answ3)
            wrong3(k,:) = wrong3(k,:) + 1;
        end
    end
end


wrongt1 = zeros(length(iters), 1);
wrongt2 = zeros(length(iters), 1);
wrongt3 = zeros(length(iters), 1);
for k=1:length(iters)
    beta1 = betas1(:,:,k);
    beta2 = betas2(:,:,k);
    beta3 = betas3(:,:,k);
    for i=1:size(xtest, 1)
        answ1 = 1/(1+exp(-xtest1_norm(i,:)*beta1 + bias1(k,:))) > .5;
        if ytest(i) ~= answ1
            wrongt1(k,:) = wrongt1(k,:) + 1;
        end
        answ2 = 1/(1+exp(-xtest2_norm(i,:)*beta2 + bias2(k,:))) > .5;
        if (ytest(i) ~= answ2)
            wrongt2(k,:) = wrongt2(k,:) + 1;
        end
        answ3 = 1/(1+exp(-xtest3_norm(i,:)*beta3 + bias3(k,:))) > .5;
        if (ytest(i) ~= answ3)
            wrongt3(k,:) = wrongt3(k,:) + 1;
        end
    end
end

plot(iters, loss1);
figure
plot(iters, loss2);
figure;
plot(iters, loss3);
figure
plot(iters, loss1);
hold all;
plot(iters, loss2);
hold all;
plot(iters, loss3);
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
