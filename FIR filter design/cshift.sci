function R = cshift(M,d)
      Fname = "cshift"
  if argn(2)==0
 head_comments(Fname)
 R = []
 return
  end
  s = size(M)
  R = M
  for i=1:length(d)
    if s(i)>1
      D = pmodulo(d(i),s(i))
      if D~=0
        S = emptystr(1,length(s))+":"
        S(i) = "[s(i)-D+1:s(i) 1:s(i)-D]"
        S = strcat(S,",")
        if typeof(R) ~= "ce"
            execstr("R = R("+S+")")
        else
            execstr("R.entries = R("+S+").entries")
        end
      end
    end
  end
endfunction
