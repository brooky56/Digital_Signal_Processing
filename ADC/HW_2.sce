b = chdir('C:\Users\work\OneDrive\Documents\SciLab\lab_v2')
exec('ADC.sce')
n = 1
fs = 100000

//quant_levels = [-0.7, -0.30, 0.35, 0.4] // [-0.1 0 0.1] 
quant_levels = [-0.95, -0.75, -0.55, -0.35, -0.15, 0, 0.15, 0.35, 0.55, 0.75, 0.95]
//quant_levels = linspace(-1, 1, 10)

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
sin_freq = 150
sin_ampl = 0.1
step_size = sin_freq*(2*%pi)/499997;
disp(step_size)
samples = [1:499997]*step_size;

sin_sig = sin_ampl*sin(samples)

sin_sig = sin_sig'

filtered = recorded_data - sin_sig

f = figure(3)
clf
plot(recorded_data, "g")
plot(sin_sig, "b")
plot(filtered, "r")
xlabel('Samples')
ylabel('Amplitude')

playsnd(filtered, fs)
