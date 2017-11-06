function [rule] = rule_mine(set, min_conf, k)
    rule = [];
    % attain frequent k-item set as combination probability density
    comb = set{k};
    comb_size = size(comb);
    for i = 1:(k-1)
        % attain frequent i-item set as prior probability density
        prior = set{i};
        prior_size = size(prior);
        for j = 1:comb_size(1)
            for n_prior = 1:prior_size(1)
                if (mean(ismember(prior(n_prior, 1:i), comb(j, 1:k))) == 1)
                    correlation = comb(j, k+1) / prior(n_prior, i+1);
                    if (correlation >= min_conf)
                        result = setdiff(comb(j, 1:k), prior(n_prior, 1:i));
                        add_rule = [i, prior(n_prior, 1:i), result, comb(j, k+1), correlation];
                        rule = [rule; add_rule];
                    end
                end
            end
        end
    end
end