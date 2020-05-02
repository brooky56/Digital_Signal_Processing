clear all;

Fs = 16 // sampling frequency
T = 4.2 // time duration 
t = (0:1/Fs:T)

f0 = 2 // signal frequency
leak1 = sin(2*%pi*f0*t) 

f0 = 3 // signal frequency
leak2 = sin(2*%pi*f0*t)

f0 = 4 // signal frequency
no_leak = sin(2*%pi*f0*t)

summ = leak1+ leak2 + no_leak

summ = resize_matrix(summ, 1,  1024)
figure(0)
plot(summ)
a = fftshift(fft(summ))
f = linspace(-Fs/2,Fs/2, length(a));

figure(1)
plot(f, abs(a))
xlabel("Frequency, Hz")
ylabel("Freq amplitude")
title("Frequency response of final signal ")

figure(2)
summ = leak1+ leak2 + no_leak

summ = resize_matrix(summ, 1,  1024)
f = (0:length(summ)-1)/length(summ) * Fs
plot(f, abs(fft(summ)))
xlabel("Frequency, Hz")
ylabel("Freq amplitude")
title("Frequency response of final signal ")
