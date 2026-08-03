% Removing all variables, functions, and MEX-files from memory, leaving the
% workspace empty.
clear all


% Deleting all figures whose handles are not hidden.
close all


% Deleting all figures including those with hidden handles.
close all hidden


% Clearing all input and output from the Command Window display giving us a clean screen.
clc


% Creating an analog input object 'ai'.
ai = analoginput ('winsound');


% Adding a hardware channel to an analog input object 'ai'.
channel_1 = addchannel (ai,1,'channel_1');


% Specifying the per-channel rate (in samples/second) that the analog input 'ai'
% subsystem converts data. 'ai' subsystems convert analog data to digital
% data.
ai.SampleRate = 8000;


% Time interval for recording speech signal.
Duration = 5;


% Setting object 'ai' properties.
set (ai,'TriggerChannel',channel_1);
set (ai,'TriggerType','Software');
set (ai,'TriggerCondition','Falling');
set (ai,'TriggerConditionValue',0.001);
set(ai, 'SamplesPerTrigger', Duration * 8000);


start(ai);


% Halting execution temporarily for certain time.
pause (Duration);


% Extracting data, time and event information from the data acquisition
% engine. The given command returns data as sample-time pairs. Time is an
% m-by-1 array of reltive time values where m is the number of samples
% returned. Relative time is measured with respect to the first sample
% loged by the data acquisition engine.
[data, time] = getdata (ai);


% Plotting the data sequence 'data' at the values specified in 'time'.
stem (time,data);


% Acquiring data from an analog input device.
while (strcmp(ai.Running,'On'))
end


% Deleting analog input object 'ai'.
delete (ai);


% Assigning acquired data to a variable 'x'.
x = data;


% Fs is the sampling rate.
Fs = 8000;


% Defining carrier frequency 'Fc'.
Fc = 500;


% Generating a carrier signal 'Cs' through linearly spaced vectors.
Cs = cos(linspace (0,2*pi*Fc,Duration*8000));


% Creating an analog output object 'ao'.
ao = analogoutput('winsound');


% Adding a hardware channel to an analog output object 'ao'.
channel_2 = addchannel(ao,1);


% Applying the amplitude modulation concept to variable 'x' by multiplying
% it with carrier signal 'Cs' after taking transpose.
% AmpMod = amod(x,Fc,Fs,'amdsb-sc',num,den);(ALTERNATIVE APPROACH)
AmpMod = x'.*Cs;


% Demodulating the signal.
% DeAmpMod = (1/2).*(ademod(AmpMod,Fc,Fs,'amdsb-sc',num,den));
% (ALTERNATIVE APPROACH)
DeAmpMod = AmpMod.*Cs;


% Designing butterworth low pass filter.
[num,den] = butter(2,.8);
FilteredOutput = filter(num,den,DeAmpMod);


% Plotting the input speech signal 'data'.
subplot(2,2,1);
axis normal;
plot(data);
grid on;
title('Initial Speech Signal');
xlabel('Samples');
ylabel('Speech Signal');


% Plotting the modulated speech signal 'AmpMod'.
subplot(2,2,2);
axis normal;
plot(AmpMod);
title('Modulated Speech Signal')
xlabel('Samples')
ylabel('Modulated Signal')


% Plotting the demodulated speech signal 'DeAmpMod'.
subplot(2,2,3)
axis normal
plot(DeAmpMod);
grid on
title('Demodulated Speech Signal')
xlabel('Samples')
ylabel('Demodulated Signal')


% Plotting the filtered speech signal 'FilteredOutput'.
subplot(2,2,4)
axis normal
plot(FilteredOutput)
grid on
title('Received Signal At Output')
xlabel('Samples')
ylabel('Filtered Signal')


% Queuing data in the engine for eventual output.
putdata(ao,DeAmpMod');


start (ao);


% Sending data to an analog output device after the triggering occurs. 
while(strcmp(ao.Running,'On'))
end


% Deleting analog output object 'ao'.
delete(ao);


% Removing items from workspace and freeing up system memory.
clear