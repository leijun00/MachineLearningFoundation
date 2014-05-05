clear ; close all; clc
error = 0;
iteration = 1000;
for i=1:iteration
    count = 1000;
    x1 = 2*rand(count,1)-1;
    x2 = 2*rand(count,1)-1;
    y = sign(x1.*x1 + x2.*x2 - 0.6);
    r = randi([1,count],count/10,1);
    y(r) = -1*y(r);
    x = [ones(count,1),x1,x2];
    a = regress(y,x);
    result = sign(x*a);
    error = error + mean(y~=result);
end
fprintf('error for linear regression: %f\n', error/iteration);

for i=1:1
    count = 1000;
    x1 = 2*rand(count,1)-1;
    x2 = 2*rand(count,1)-1;
    y = sign(x1.*x1 + x2.*x2 - 0.6);
    r = randi([1,count],count/10,1);
    y(r) = -1*y(r);
    x = [ones(count,1),x1,x2,x1.*x2,x1.*x1,x2.*x2];
    a = regress(y,x);
end
fprintf('%f ', a);
fprintf('\n');

error = 0;
iteration = 1000;
for i=1:iteration
    count = 1000;
    x1 = 2*rand(count,1)-1;
    x2 = 2*rand(count,1)-1;
    y = sign(x1.*x1 + x2.*x2 - 0.6);
    r = randi([1,count],count/10,1);
    y(r) = -1*y(r);
    x = [ones(count,1),x1,x2,x1.*x2,x1.*x1,x2.*x2];
    result = sign(x*a);
    error = error + mean(y~=result);
end
fprintf('error for linear regression with feature transform: %f\n', error/iteration);

% Logistic regression
train_data = load('ntumlone-hw3-hw3_train.dat');
[m,n] = size(train_data);
x = train_data(:,1:n-1);
x = [ones(m,1) x];
y = train_data(:,n);

iteration=2000;

theta1 = zeros(n,1);
for i=1:iteration
    s = sigmoid(-y.*(x*theta1));
    grad = -x' * (s .* y)/ m;
    theta1 = theta1 - 0.001 * grad;
end

theta2 = zeros(n,1);
for i=1:iteration
    s = sigmoid(-y.*(x*theta2));
    grad = -x' * (s .* y)/ m;
    theta2 = theta2 - 0.01 * grad;
end

theta3 = zeros(n,1);
for i=1:iteration
    index = rem(i, m);
    if index == 0
        index = m;
    end
    s = sigmoid( -y(index)*(x(index,:)*theta3));
    grad = -x(index,:)' * s * y(index);
    theta3 = theta3 - 0.001 * grad;
end

test_data = load('ntumlone-hw3-hw3_test.dat');
[m,n] = size(test_data);
x = test_data(:,1:n-1);
x = [ones(m,1),x];
y = test_data(:,n);
prediction1 = sign(x*theta1);
prediction2 = sign(x*theta2);
prediction3 = sign(x*theta3);
fprintf('error for logistic regression(rate=0.001): %f\n', mean(prediction1~=y));
fprintf('error for logistic regression(rate=0.01): %f\n', mean(prediction2~=y));
fprintf('error for logistic regression sgd: %f\n', mean(prediction3~=y));
    

    
    






