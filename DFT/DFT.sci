function f = DFT(x)
    n = length(x)
    x1 = [x]
    for i = 1:n
        a = 0
        for k = 1:n
            p = exp(2*%pi*-%i*i*k/n);
            a = a+x(k)*p;    
        end
        x1(i) = a
    end
    f = x1
endfunction
