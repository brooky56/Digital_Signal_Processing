function H = ideal_highpass(N, cutoff, stop_value)
    N = (N - modulo(N,2)) / 2
    cutoff = floor(2 * N * cutoff)
    H = ones(1, N) * stop_value
    H(1,cutoff:N) = 1.
    H = [0. H flipdim(H, 2)] 
endfunction
