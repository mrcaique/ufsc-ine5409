function M = multiplicity(r)
    r_lim = 1e-4 * r(length(r));
    M = 1;
    remainder_sum = abs(r(1)) + abs(r(2));
    while remainder_sum < r_lim
        M = M + 1;
        remainder_sum = remainder_sum + abs(r(M+1));
    end
end
