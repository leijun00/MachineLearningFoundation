clear ; close all; clc

train_data = load('ntumlone-hw4-hw4_train.dat');
test_data = load('ntumlone-hw4-hw4_test.dat');

%% Q13
[m,n] = size(train_data);
x = train_data(:,1:n-1);
x = [ones(m,1) x];
y = train_data(:,n);
theta = (x'*x + 10 * eye(n)) \ (x'*y);
prediction = sign(x*theta);
fprintf('Q13 Ein: %f, ', mean(y ~= prediction));

[m,n] = size(test_data);
x_test = test_data(:,1:n-1);
x_test = [ones(m,1),x_test];
y_test = test_data(:,n);
prediction = sign(x_test*theta);
fprintf('Eout: %f\n', mean(y_test ~= prediction));

%% Q14
error = inf;
lambda = inf;
theta = zeros(n,n);
candidates = 2:-1:-10;
for elm = candidates
    candidate_lambda = mpower(10,elm);
    candidate_theta = (x'*x + candidate_lambda * eye(n)) \ (x'*y);
    prediction = sign(x*candidate_theta);
    current_error = mean(y ~= prediction);
    if current_error < error
        error = current_error;
        lambda = elm;
        theta = candidate_theta;
    end
end
fprintf('Q14 lambda: %f, Ein: %f, ', lambda, error);
prediction = sign(x_test*theta);
fprintf('Eout: %f\n', mean(y_test ~= prediction));

%% Q15
error = inf;
lambda = inf;
theta = zeros(n,n);
candidates = 2:-1:-10;
for elm = candidates
    candidate_lambda = mpower(10,elm);
    candidate_theta = (x'*x + candidate_lambda * eye(n)) \ (x'*y);
    prediction = sign(x_test*candidate_theta);
    current_error = mean(y_test ~= prediction);
    if current_error<error
        error = current_error;
        lambda = elm;
        theta = candidate_theta;
    end
end
fprintf('Q15 lambda: %f, Ein: %f, ', lambda, mean(y~=sign(x*theta)));
fprintf('Eout: %f\n', error);

%% Q16
m = size(x,1);
x_train = x(1:120,:);
y_train = y(1:120);
x_cv = x(121:m,:);
y_cv = y(121:m);
error = inf;
lambda = inf;
theta = zeros(n,n);
candidates = 2:-1:-10;
for elm = candidates
    candidate_lambda = mpower(10,elm);
    candidate_theta = (x_train'*x_train + candidate_lambda * eye(n)) \ (x_train'*y_train);
    prediction = sign(x_train*candidate_theta);
    current_error = mean(y_train ~= prediction);
    if current_error<error
        error = current_error;
        lambda = elm;
        theta = candidate_theta;
    end
end
fprintf('Q16 lambda: %f, Etrain: %f, ', lambda, error);
fprintf('Ecv: %f, ', mean(y_cv~=sign(x_cv*theta)));
fprintf('Eout: %f\n', mean(y_test~=sign(x_test*theta)));

%% Q17
error = inf;
lambda = inf;
theta = zeros(n,n);
candidates = 2:-1:-10;
for elm = candidates
    candidate_lambda = mpower(10,elm);
    candidate_theta = (x_train'*x_train + candidate_lambda * eye(n)) \ (x_train'*y_train);
    prediction = sign(x_cv*candidate_theta);
    current_error = mean(y_cv ~= prediction);
    if current_error<error
        error = current_error;
        lambda = elm;
        theta = candidate_theta;
    end
end
fprintf('Q17 lambda: %f, Etrain: %f, ', lambda, mean(y_train~=sign(x_train*theta)));
fprintf('Ecv: %f, ', error);
fprintf('Eout: %f\n', mean(y_test~=sign(x_test*theta))); 

%% Q18
theta = (x'*x + mpower(10, lambda) * eye(n)) \ (x'*y);
fprintf('Q18 Ein: %f, Eout: %f \n', mean(y~=sign(x*theta)), mean(y_test~=sign(x_test*theta)));

%% Q19
x1 = x(1:40,:); y1 = y(1:40);
x2 = x(41:80,:); y2 = y(41:80);
x3 = x(81:120,:); y3 = y(81:120);
x4 = x(121:160,:); y4 = y(121:160);
x5 = x(161:200,:); y5 = y(161:200);
x_train = zeros(160,n);
x_cv = zeros(40,n);
y_train = zeros(160,1);
y_cv = zeros(40,1);

error = inf;
lambda = inf;
candidates = 2:-1:-10;
for elm = candidates
    total_error = 0;
    for i=1:5
        if i==1
            x_train = [x2;x3;x4;x5]; y_train=[y2;y3;y4;y5];
            x_cv = x1; y_cv = y1;
        end
        if i==2
            x_train = [x1;x3;x4;x5]; y_train =[y1;y3;y4;y5];
            x_cv = x2; y_cv = y2;
        end
        if i==3
            x_train = [x1;x2;x4;x5]; y_train =[y1;y2;y4;y5];
            x_cv = x3; y_cv = y3;
        end
        if i==4
            x_train = [x1;x2;x3;x5]; y_train =[y1;y2;y3;y5];
            x_cv = x4; y_cv = y4;
        end
        if i==5
            x_train = [x1;x2;x3;x4]; y_train =[y1;y2;y3;y4];
            x_cv = x5; y_cv = y5;
        end   
        candidate_lambda = mpower(10,elm);
        candidate_theta = (x_train'*x_train + candidate_lambda * eye(n)) \ (x_train'*y_train);
        prediction = sign(x_cv*candidate_theta);
        ecv = mean(y_cv ~= prediction);
        total_error = total_error + ecv; 
    end
    %fprintf('Q19 lamda: %d, Ecv: %f\n', elm, total_error/5);
    if total_error/5 < error
        error = total_error/5;
        lambda = elm;
    end
end
fprintf('Q19 lamda: %d, Ecv: %f\n', lambda, error);

%%Q20
theta = (x'*x + mpower(10,lambda) * eye(n)) \ (x'*y);
prediction = sign(x*theta);
ein = mean(y ~= prediction);
prediction = sign(x_test*theta);
eout = mean(y_test ~= prediction);
fprintf('Q20 Ein: %f, Eout: %f\n', ein, eout);








