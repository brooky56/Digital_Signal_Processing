function [flt] = get_filter(a, b)
	flt = struct('a', a, 'b', b, 'buff_in', zeros(1, size(b, '*')), 'buff_out', zeros(1, size(a, '*')));
endfunction 

function [flt_out, signal] = push_signal(x, flt_in)
	flt_in.buff_in(2:$) = flt_in.buff_in(1:$-1)
	flt_in.buff_in(1) = x;
	out_sum = flt_in.buff_in*flt_in.b';
	out_sum = out_sum + flt_in.buff_out*flt_in.a';
	flt_in.buff_out(2:$) = flt_in.buff_out(1:$-1)
	flt_in.buff_out(1) = out_sum;

	flt_out = flt_in;
	signal = out_sum;
endfunction