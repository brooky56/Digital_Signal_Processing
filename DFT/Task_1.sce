clear all;

b = chdir('C:\Users\work\OneDrive\Documents\SciLab\lab_v5')
exec('DFT.sci')
exec('FFT.sci')

figure(0)
f = 5;
Fs = 64;
dt=1/Fs;
T = 4;
t =0:dt:T-dt;
signal = cos(2*%pi*f*t);
plot(signal);
xlabel("Time")
ylabel("Amplitude")

figure(1)
subplot(2,1,1)
a = DFT(signal)
frequinces = (0:length(signal)-1)/length(signal)*Fs;
plot(frequinces, abs(a))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal (my dft)", 'fontsize', 3)

subplot(2,1,2)
plot(frequinces, abs(fft(signal)))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal (build-in function)", 'fontsize', 3)

figure(2)
subplot(2,1,1)
a = DFT(signal)
a = fftshift(a)
frequinces = linspace(-Fs/2, Fs/2, length(a));
plot(frequinces, abs(a))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal (my dft)", 'fontsize', 3)

subplot(2,1,2)
a = fft(signal)
a = fftshift(a)
frequinces = linspace(-Fs/2, Fs/2, length(a));
plot(frequinces, abs(a))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal (build-in function)", 'fontsize', 3)

figure(3)
b = FFT(signal)
b = fftshift(b)
plot(frequinces, abs(b))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal (my fft)", 'fontsize', 3)

