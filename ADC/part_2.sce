n = 2

//Task 1
recorded_data_2 = ADC(n, quant_levels, fs)
f = figure(1) // set figure's number
clf // clear figure
plot(recorded_data_2)
gca.data_bounds = [0,-2; fs,2]
xlabel('Samples')
ylabel('Amplitude')

//Task 2
recorded_data_2 = recorded_data_2 - mean(recorded_data_2)
f = figure(2) // set figure's number
plot(recorded_data_2)
gca.data_bounds = [0,-2; fs,2]
xlabel('Samples')
ylabel('Amplitude')

//Task 3
sin_freq = 180
sin_ampl = 0.1
step_size = sin_freq*(2*%pi)/length(recorded_data_2);
disp(step_size)
samples = [1:length(recorded_data_2)]*step_size;

sin_sig = sin_ampl*sin(samples)

sin_sig = sin_sig'

filtered_2 = recorded_data_2 - sin_sig

f = figure(3)
clf
plot(recorded_data_2, "g")
plot(sin_sig, "b")
plot(filtered_2, "r")
xlabel('Samples')
ylabel('Amplitude')

clf
analyze(recorded_data_2, 20, 215, fs, length(recorded_data_2))

exec('ps.sce')

ps(filtered_2, fs)
