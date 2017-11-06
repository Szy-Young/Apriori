function [can_set] = candidate(k, set)
    set_size = size(set);
    can_set = [];
    
    % generate C_k according to L_k-1
    for i = 1:(set_size(1)-1)
        for j = (i+1):set_size(1)
            p = union(set(i, 1:(k-1)), set(j, 1:(k-1)));
            p_size = size(p);
            if (p_size(2) == k)
                can_set = [can_set; p];
            end
        end
    end
    
    % pruning C_k
    if (k ~= 2)
        % as for k>2, elements which appear in unpruned candidate set less
        % than k times should be pruned
        prune_set = [];
        can_set_size = size(can_set);
        count = 0;
        index = [];
        
        % every time count appearances of an element, then add it to pruned
        % set if qualified and delete all the copies from original
        % candidate set
        while (can_set_size(1)>(k-1))
            for j = 1:can_set_size(1)
                p = intersect(can_set(j, :), can_set(1,:));
                p_size = size(p);
                if (p_size(2) == k)
                    count = count + 1;
                    index = [index, j];
                end
            end
            
            if (count >= k)
                prune_set = [prune_set; can_set(1, :)];
            end
            
            can_set(index, :) = [];
            can_set_size = size(can_set);
            count = 0;
            index = [];
        end
        can_set = prune_set;
    end
end