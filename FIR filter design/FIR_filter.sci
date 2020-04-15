function H = FIR_filter(fc1, fc2, fs)
    w1 = (2*%pi)*(fc1/fs ) ;
    w2 = (2*%pi)*(fc2/fs ) ;
    M=1023;
    wc1 = w1 / %pi ;
    wc2 = w2 / %pi ;
    disp(wc1, 'Normalized digital lower cutoff frequency in cycles/samples');
    disp(wc2, 'Normalized digital lower cutoff frequency in cycles/samples');
    [wft,wfm,fr]= wfir('bp' ,M+1 ,[wc1/2 ,wc2/2], 're', [0,0]);
    disp(wft,'Impulse Response of FIR Filter: h[n]= ');
    H = wfm
    subplot(2 ,1 ,1);
    plot(2*fr, wfm);
    xlabel('Normalized Digital Frequency w−−−> ');
    ylabel('Magnitude |H(w)|= ');
    title('Magnitude Response of FIR BPF');
    xgrid(1);
    subplot(2 ,1 ,2);
    plot(fr*fs, wfm);
    xlabel('Analog Frequency in Hz f −−−> ');
    ylabel('Magnitude |H(w)|= ');
    title('Magnitude Response of FIR BPF');
    xgrid (1);
    
endfunction
