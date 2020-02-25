b = chdir('C:\Users\work\OneDrive\Documents\SciLab\lab_v2')
exec('ADC.sce')

n = 1
fs = 22050
quant_levels = linspace(-1, 1, 10)

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


