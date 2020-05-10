function f = DIST_F(x, a, b)
    f = x
    for i = 1:length(f)
        f(i) = a * atan(b*f(i))
    end
endfunction
