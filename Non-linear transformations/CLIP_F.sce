function f  = CLIP_F(x, l)
    f = x
    f(abs(x) >  l) = sign(f(abs(x) >  l)) .* l
endfunction
