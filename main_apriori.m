clc;
clear;
data = importdata('retail.txt');
data_size = size(data);
num = data_size(1);

% item 1 ~ 16469   
item = 16470;

% sample the dataset to test the algorithm firstly
percent = 1;
num_sample = round(num*percent/100);
sample_index = randperm(num, num_sample);
sample = data(sample_index, :);

% set parameters for Apriori algorithm
min_sup = 0.01;
min_conf = 0.4;

% perform Apriori algorithm
[rule] = apriori(sample, min_sup, min_conf, item);

% out put the rules satisfied minimum support and confidence
fprintf('here are our rules:\n');
rule_size = size(rule);
n_rule = rule_size(2);
for i = 1:n_rule
    this_rule = rule{i};
    this_size = size(this_rule);
    n_this_rule = this_size(1);
    for j = 1:n_this_rule
        seg = this_rule(j, 1);
        for reason = 2:(seg+1)
            fprintf('%d, ', this_rule(j, reason));
        end
        fprintf('--> ');
        for result = (seg+2):(i+2)
            fprintf('%d, ', this_rule(j, result));
        end
        fprintf('support: %d, confidence: %d\n', this_rule(j, i+3), this_rule(j, i+4));
    end
end