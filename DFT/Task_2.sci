clear all;

Fs = 64 // sampling frequency
T = 4.2 // time duration 
t = (0:1/Fs:T)

f0 = 1 // signal frequency
leak1 = sin(2*%pi*f0*t) 

f0 = 3 // signal frequency
leak2 = sin(2*%pi*f0*t)

f0 = 4 // signal frequency
no_leak = sin(2*%pi*f0*t)
    
figure(0)
subplot(4,1,1)
plot([leak1, leak1])
xlabel("Samples", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("With leakage")
subplot(4,1,2)
plot([leak2, leak2])
xlabel("Samples", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("With leakage")
subplot(4,1,3)
plot([no_leak, no_leak])
xlabel("Samples", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("Without leakage")
subplot(4,1,4)
plot(leak1+leak2+no_leak)
xlabel("Samples", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("Sum of signals")

figure(1)
subplot(4,1,1)
f1 = (0:length(leak1)-1)/length(leak1)*Fs
plot(f1, abs(fft(leak1)))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal", 'fontsize', 3)

subplot(4,1,2)
f2 = (0:length(leak2)-1)/length(leak2)*Fs
plot(f2, abs(fft(leak2)))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal", 'fontsize', 3)

subplot(4,1,3)
f3 = (0:length(no_leak)-1)/length(no_leak)*Fs
plot(f3, abs(fft(no_leak)))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal", 'fontsize', 3)

figure(2)
a = leak1+ leak2+no_leak
a = fft(a)
a = fftshift(a)
f = linspace(-Fs/2, Fs/2, length(a));
plot(f, abs(a))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal", 'fontsize', 3)

figure(3)
no_leak1 = sin(2*%pi*f0*t)
no_leak2 = 2*sin(2*%pi*f0*t)
no_leak3 = 4*sin(2*%pi*f0*t)

a1 = fftshift(fft(no_leak1))
a2 = fftshift(fft(no_leak2))
a3 = fftshift(fft(no_leak3))

f = linspace(-Fs/2, Fs/2, length(a1));

plot(f, abs(a1), 'b')
plot(f, abs(a2), 'r')
plot(f, abs(a3), 'g')
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signal", 'fontsize', 3)
legend(['A = 1';'A = 2';'A = 4'])
