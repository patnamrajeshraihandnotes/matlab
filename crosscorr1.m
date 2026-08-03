N=1024; %%%% Number of samples to generate
f1=1;   %%%% frequency of the sine wave
Fs=200;   %%%% sampling frequency
n=0:N-1;     %%%%% sampling index
x=sin(2*pi*f1*n/Fs);    %%% generate x(n)
y=x+10*randn(1,N);    %%% generate y(n)
subplot(3,1,1),plot(x)
title('pure sine wave')
grid on;
subplot(3,1,2), plot(y);
title('y(n) a pure sine wave +noise')
grid on;
Rxy=xcorr(x,y); %%%% estimate the cross correlation
subplot(3,1,3);
plot(Rxy);
title('cross correlation Rxy')
grid on;