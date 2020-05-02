clear all;

f1 = 190;
A1 = 0.5
f2 = 10;
A2 = 2;
fs =  200;
dt  = 1/fs;
T = 0.5
t =0:dt:T-dt;

s1 = A1*cos(2*%pi*f1*t);
s2 = A2*cos(2*%pi*f2*t);

figure(0)
plot(t, s1, 'b');
plot(t, s2, 'r');
xlabel("Time, s", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("Time domain", 'fontsize', 3)

figure(1)
subplot(3,1,1)
f1 = (0:length(s1)-1)/length(s1)*fs
plot(f1, abs(fft(s1)), 'b')
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of first signal", 'fontsize', 3)
subplot(3,1,2)
f2 = (0:length(s2)-1)/length(s2)*fs
plot(f2, abs(fft(s2)), 'r')
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of second signal", 'fontsize', 3)

subplot(3,1,3)
f2 = linspace(-fs/2, fs/2, length(s2))
plot(f2, abs(fftshift(fft(s2))), 'r')
f1 = (0:length(s1)-1)/length(s1)*fs
plot(f2, abs(fftshift(fft(s1))), 'b')
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final signals", 'fontsize', 3)
legend(["freq = 10";"freq = 190"])
