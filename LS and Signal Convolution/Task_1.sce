clc;
clear all;
close;

signal_name = ['voice.wav', 'drums.wav', 'speech.wav', 'music.wav']
f = figure(1)

for i = 1:4
    // Our recorded IRC
    [h, Fs_h, h_bits] = wavread("C:\Users\work\OneDrive\Documents\SciLab\lab_v3\echo.wav");

    // Our signal (sound)
    [x, Fs_x, x_bits] = wavread("C:\Users\work\OneDrive\Documents\SciLab\lab_v3\" + signal_name(i));
    
    x = x(1, :)
    h = h(1, :)
    h = h*0.01
    
    shift = length(h) + length(x) -1;
    
    irc = zeros (1, shift - length(h));
    signal = zeros (1, shift - length(x));
    
    x_signal = [x signal];
    h_irc = [h irc];

    ch = input('Choose: 1(Selfmade) or 0(Convol)');

    if(ch == 1)
        // Our Convoluting algorithm using FFT
        tic();
        result = ifft(fft(x_signal) .* fft(h_irc));
        t = toc();
        disp(t);
        subplot(4, 2, i * 2);
        plot(result, "-b");
        xtitle(signal_name(i) + " with our IRC");
    end;
    
    if(ch == 1)
        // Convolution from scilab
        tic();
        result = convol(x, h);     
        t = toc();
        disp(t);
        subplot(4, 2, i * 2 - 1);
        plot(result, "-r");
        xtitle(signal_name(i) + " with our IRC of Scilab function");
    end;
    
    playsnd(result, Fs_x);
end

