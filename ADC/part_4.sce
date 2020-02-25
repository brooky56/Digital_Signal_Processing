b = chdir('C:\Users\work\OneDrive\Documents\SciLab\lab_v2')
exec('ADC.sce')

n = 4
fs = 100000
quant_levels = linspace(-1, 1, 1000)

//Task 1
recorded_data = ADC(n, quant_levels, fs)
f = figure(1) // set figure's number
clf // clear figure
plot(recorded_data)
gca.data_bounds = [0,-2; fs,2]
xlabel('Samples')
ylabel('Amplitude')

//Task 2
recorded_data = recorded_data - mean(recorded_data)
f = figure(2) // set figure's number
plot(recorded_data)
gca.data_bounds = [0,-2; fs,2]
xlabel('Samples')
ylabel('Amplitude')

//Task 3
sin_freq = 195
sin_ampl = 0.1
step_size = sin_freq*(2*%pi)/length(recorded_data);
disp(step_size)
samples = [1:length(recorded_data)]*step_size;

sin_sig = sin_ampl*sin(samples)

sin_sig = sin_sig'

filtered_1 = recorded_data - sin_sig


//analyze(recorded_data, 20, 215, fs, length(recorded_data))


f = figure(4)
plot(recorded_data, "g")
plot(sin_sig, "b")
plot(filtered_1, "r")
xlabel('Samples')
ylabel('Amplitude')


f = figure(5)
plot(filtered_1, "r")
xlabel('Samples')
ylabel('Amplitude')

playsnd(filtered_1, fs)
