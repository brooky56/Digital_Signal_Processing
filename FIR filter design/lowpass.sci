function H = lowpass(fc, fs, M)
    w = (2* %pi ) *( fc / fs ) ;
    wc = w/ %pi ;
    [wft,wfm,fr]= wfir('lp',M+1,[wc/2,0],'re',[0,0]);
    H = wfm
endfunction
