function [rule] = apriori(sample, min_sup, min_conf, item)
    sample_size = size(sample);
    num_sample = sample_size(1);
    k = 1;
    rule = {};
    can_set = (linspace(0, item-1, item))';
    can_set = [can_set, zeros(item, 1)];
    
    % save number of transactions since dataset will be contracted
    % gradually
    num_all = num_sample;
    
    % propose frequent 1-item set
    for i = 1:num_sample
        j = 1;
        while(~isnan(sample(i,j)))
            can_set((sample(i,j)+1), 2) = can_set((sample(i,j)+1), 2) + 1;
            j = j + 1;
            if (j==31)
                break;
            end
        end
    end
    can_set(:, 2) = can_set(:, 2) ./ num_sample;
    set = can_set(find(can_set(:,2) >= min_sup), :);
    set = {set};
    
    while(1)
       k = k + 1;
       % propose candidate k-item set
       [can_set] = candidate(k, set{k-1});
       fprintf('got candidate %d-item set\n', k);
       
       if (min(size(can_set)) == 0)
           fprintf('empty candidate %d-item set\n', k);
           break;
       end
       
       % generate frequent k-item set along with contracting sample dataset
       [add_set, contract_sample] = frequent(k, can_set, sample, num_sample, num_all, min_sup);
       fprintf('got frequent %d-item set\n', k);
       
       if (min(size(add_set)) == 0)
           fprintf('empty frequent %d-item set\n', k);
           break;
       end
       set = [set, add_set];
       
       sample = contract_sample;
       sample_size = size(sample);
       num_sample = sample_size(1);
       
       % mine strong correlation rules including k items
       [add_rule] = rule_mine(set, min_conf, k);
       rule = [rule, add_rule];
    end
end



