function [set, contract_sample] = frequent(k, can_set, sample, num_sample, num_all, min_sup)
    can_set_size = size(can_set);
    set = [can_set, zeros(can_set_size(1), 1)];
    index = [];
    for i = 1:can_set_size(1)
        for j = 1:num_sample
            p = intersect(can_set(i, 1:k), sample(j, :));
            p_size = size(p);
            if (p_size(2) == k)
                set(i, k+1) = set(i, k+1) + 1;
                index = [index, j];
            end
        end
        set(i, k+1) = set(i, k+1) / num_all;
    end
    set = set(find(set(:,k+1) >= min_sup), :);
    
    % contract the sample dataset
    index = unique(index);
    contract_sample = sample(index, :);
end