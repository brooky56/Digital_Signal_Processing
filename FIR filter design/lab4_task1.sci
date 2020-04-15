clc;
clear all;
close;
//-----------------------------------------------------------------------------
b = chdir('C:\Users\work\OneDrive\Documents\SciLab\lab_v4')
exec('ideal_lowpass.sci')
exec('ideal_highpass.sci')
exec('cshift.sci')
load("signal_with_noise_and_filtered.sod")
//-----------------------------------------------------------------------------
//Generate filters
high = ideal_highpass(1024, 0.001, 0.);
high_len = length(high)
frequencies_high = (0:high_len-1)/high_len * Fs;
highpass = real(ifft(high))
//shifting
highpass = cshift(highpass, [0 (high_len - modulo(high_len,2))/2])

low = ideal_lowpass(1024, 0.15, 0.);
low_len = length(low)
frequencies_low = (0:low_len-1)/low_len * Fs;
lowpass = real(ifft(low))
//shifting
lowpass = cshift(lowpass, [0 (low_len - modulo(low_len,2))/2])
//-----------------------------------------------------------------------------
//Plotting filters
figure(0)
subplot(2 ,1 ,1);
plot2d("nn", frequencies_high, high, color("blue"))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of ideal low-pass filter", 'fontsize', 3)
xgrid(1)
subplot(2 ,1 ,2);
plot2d("nn", frequencies_low, low, color("blue"))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of ideal high-pass filter", 'fontsize', 3)
xgrid(1)
//-----------------------------------------------------------------------------
figure(1)
//Convol two filters and apply window to decay impulse response to 0
band_pass = convol(lowpass, highpass)
band_pass = band_pass.* window('kr', length(band_pass), 8)
fre = (0:length(band_pass)-1)/length(band_pass) * Fs
plot2d("nn", fre, abs(fft(band_pass)), color("blue"))
xlabel("Frequency, Hz", 'fontsize', 2)
ylabel("Freq amplitude", 'fontsize', 2)
title("Frequency response of final filter", 'fontsize', 3)
result = convol(signal_with_noise, band_pass)
//-----------------------------------------------------------------------------
figure(2)
subplot(2, 1, 1)
plot(signal_with_noise)
xlabel("Time")
ylabel("Amplitude")
title("Before filtering")
subplot(2, 1, 2)
plot(result)
xlabel("Time")
ylabel("Amplitude")
title("After filtering")
savewave("C:\Users\work\OneDrive\Documents\SciLab\lab_v4\filtered", result, Fs)
