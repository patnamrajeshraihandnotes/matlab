%%%%%%%%%%%%% estimating the power spectral density %%%%%%%%

clear all;
close all;
N=1024; %%% total number of samples
fs=8000; %%%%%%% sampling frequency
f1=500;
f2=1000;
f3=1500;
n=0:N-1;
 
%%%% generate the signal %%%%%%%%%%
x=sin(2*pi*(f1/fs)*n)+sin(2*pi*(f2/fs)*n)+sin(2*pi*(f3/fs)*n);
pxx=spectrum(x,N); %%%%%%%%%% estimate the spectrum
specplot(pxx,fs); %%%%%%%%%% plot the spectrum
grid on;
title('power spectrum of x(n)');
xlabel('frequency in Hz');
ylabel('Magnitude in dB')