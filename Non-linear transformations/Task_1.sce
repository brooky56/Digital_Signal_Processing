clear all;
close;
clf();
//-----------------------------------------------------------------------------
s = chdir('C:\Users\work\OneDrive\Documents\SciLab\lab_v6')
exec('CLIP_F.sce')
exec('DIST_F.sci')
// Our recorded IRC
[signal, Fs, s_b] = wavread("C:\Users\work\OneDrive\Documents\SciLab\lab_v6\guitar.wav");
signal = signal(1, :)

// Before applying filter res
frequinces = (0:length(signal)-1)/length(signal) * Fs;
figure(0)
subplot(3,1,1)
plot(signal)
xlabel("Time", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("Time domain original signal", 'fontsize', 3)
subplot(3,1,2)
plot2d("nl", frequinces, abs(fft(signal)),2)
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of signal", 'fontsize', 3)
subplot(3,1,3)
s = abs(fft(signal))
s(s>0.1) = 0
plot2d("nl", frequinces, s,2)
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of signal with treshold 0.1", 'fontsize', 3)

//Applying CLIP filter
signal_clip = CLIP_F(signal, 0.1)
frequinces = (0:length(signal_clip)-1)/length(signal_clip) * Fs;
figure(1)
subplot(3,1,1)
plot(signal_clip)
xlabel("Time", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("Time domain clipped signal", 'fontsize', 3)
subplot(3,1,2)
plot2d("nl", frequinces, abs(fft(signal_clip)), 2)
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of signal", 'fontsize', 3)
subplot(3,1,3)
s = abs(fft(signal_clip))
s(s>0.1)=0
plot2d("nl", frequinces, s, 2)
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of signal", 'fontsize', 3)

//Play clipped sound
savewave('clipped.wav', signal_clip, Fs)


//Applying DISTORTION filter
signal_dist = DIST_F(signal, 3, 5)
frequinces = (0:length(signal_dist)-1)/length(signal_dist) * Fs;
figure(2)
subplot(3,1,1)
plot(signal_dist)
xlabel("Time", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("Time domain distortion effect", 'fontsize', 3)
subplot(3,1,2)
plot2d("nl", frequinces, abs(fft(signal_dist)), 2)
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of signal", 'fontsize', 3)
subplot(3,1,3)
s = abs(fft(signal_dist))
s(s>3) = 0
plot2d("nl", frequinces, s, 2)
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of signal", 'fontsize', 3)
//Play disted sound
savewave('distortion.wav', signal_dist, Fs)


