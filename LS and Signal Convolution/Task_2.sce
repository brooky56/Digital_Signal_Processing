exec('filter.sce');

[snd, y] = loadwave('Violin_Viola_Cello_Bass.wav');
out_lowpass = zeros(1, size(snd, '*'));
out_highpass = zeros(1, size(snd, '*'));

lowpass = get_filter([1.9733442497812987, -0.9736948719763], [0.00008765554875401547, 0.00017531109750803094, 0.00008765554875401547]);
highpass = get_filter([-0.3769782747249014, -0.19680764477614976], [0.40495734254626874, -0.8099146850925375, 0.4049573425462687]);
for i = 1:size(snd, '*') 
	[lowpass, output] = push_signal(snd(i), lowpass);
	out_lowpass(i) = output;
	[highpass, output] = push_signal(snd(i), highpass);
	out_highpass(i) = output;
    if modulo(i, 1000) == 0 then
        disp(i);
    end
end

savewave('lowpass.wav', out_lowpass, y(3));
savewave('highpass.wav', out_highpass, y(3));
