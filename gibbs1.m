%Gibbs Phenomenon
clc; % clear command window
clear; % clear all stored variables
N=51:50:501; %Number of points in each sinc Function
for i=N,
    max=(0.5*(i-1))/2;
    time = -max:0.5:max;
    disp(length(time));

%Sinc Function
    x= sin(time)./time;
    x(isnan(x))=1; % Special case to handle sinc(0)
    subplot(2,1,1);
    stem(time,x);
    title(['Sinc Function (sin(t)/t) with N=',num2str(i)]);
    xlabel('Samples');
    ylabel('Amplitude');
%Take FFT
    L=length(x);
    NFFT = 2^nextpow2(L); % Next power of 2 from length of x
    X = fft(x,NFFT)/L;
    X = fftshift(X);
    f = (-NFFT/2:NFFT/2-1)/NFFT;

    subplot(2,1,2);
    plot(f,2*abs(X)) ;
    title('Frequency response of Sinc (FFT)');
    xlabel('Normalized Frequency');
    ylabel('Magnitude');
    pause;  % wait for user input to continue
end

