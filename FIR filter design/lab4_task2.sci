clc;
clear all;
close;
//-----------------------------------------------------------------------------
b = chdir('C:\Users\work\OneDrive\Documents\SciLab\lab_v4')
//read data
[irc_my, Fs_irc, h_bits] = wavread("C:\Users\work\OneDrive\Documents\SciLab\lab_v4\1a_marble_hall.wav")
[signal, Fs_s, s_bits] = wavread("C:\Users\work\OneDrive\Documents\SciLab\lab_v4\7cef8230.wav")

irc_my = irc_my(1,:)
signal = signal(1,:)

// as it presented in doc with some mofification finding inverse filter steps:
filter_my_irc = conj(fft(irc_my))./abs(fft(irc_my))^2
// inverse filter
len = length(filter_my_irc)
filter_not_shifted = real(filter_my_irc)
frequencies = (0:len-1)/len * Fs_irc;

filter_my_irc = ifft(filter_my_irc)
len = length(filter_my_irc)
filter_not_shifted = real(filter_my_irc)
frequencies = (0:len-1)/len * Fs_irc;

//plot filter
figure(0)
plot(filter_my_irc)
xlabel("Time", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("IRC inverse filter")

//shifting impulse response
filter_shifted = cshift(filter_not_shifted, [0 (len - modulo(len, 2)) / 2])
reslut_filter = filter_shifted .* window('kr', length(filter_shifted), 8)
figure(1)
plot(reslut_filter)
xlabel("Time", 'fontsize', 2)
ylabel("Amplitude", 'fontsize', 2)
title("IRC inverse filter Impulse response")

// applying filter
figure(2)
signal_with_effect = convol(irc_my, signal)
filtered = convol(signal_with_effect, reslut_filter)
subplot(2, 1, 1)
plot(signal_with_effect)
xlabel("Time")
ylabel("Amplitude")
title("Before filtering")
subplot(2, 1, 2)
plot(filtered)
xlabel("Time")
ylabel("Amplitude")
title("After filtering")
savewave("C:\Users\work\OneDrive\Documents\SciLab\lab_v4\without_effect_with_irc", filtered, Fs_s)

