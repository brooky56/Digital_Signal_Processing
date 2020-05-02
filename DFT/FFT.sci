function f = FFT(x)
   n = length(x);
    if n == 1 then
        f = x;
    else
        m = n/2;
        odd = FFT(x(1:2:(n-1)));
        even = FFT(x(2:2:n));
        d = exp(-2 * %pi * %i / n) .^ (0:m-1);
        z = d .* even;
        f = [ odd + z , odd - z ];
    end
endfunction
