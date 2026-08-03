
t=0:0.0001:6

%unit impulse

y1= [1 zeros(1,99)];

%figure,plot(y1)

%%%% unit step

y2=ones(1,100);

%figure,stem(y2)

%%%% unit ramp %%%%%

y3=t;
%figure,stem(y3)

%%%%%%%% quadratic signal %%%%%%%

y4=t.^2;

figure,
subplot(2,2,1),stem(y1)
subplot(2,2,2),stem(y2)
subplot(2,2,3),stem(y3)
subplot(2,2,4),stem(y4)
%%%%%%%%% cubic %%%%%%%%%%%

y5=t.^3;

figure,stem(y5)

%%%%%%%%%%% square wave %%%%%%%%

y6=square(4*pi*t);

figure,stem(y6)

%%%%%%%%%%%%% sawtooth wave %%%%%%%%%%%%%%%%%%

fs=10000;
t=0:1/fs:20;

y7=sawtooth(2*pi*t,0.5);

figure,stem(y7)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Aperidoic Waveforms %%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%% gaussian pulse %%%%%%%%%%%%%%%


%Plot a 50 kHz Gaussian RF pulse with 60% bandwidth, sampled at a rate of 1 MHz. Truncate the pulse where the envelope falls 40 dB below the peak:

tc = gauspuls('cutoff',50e3,0.6,[],-40); 
t = -tc : 1e-6 : tc; 
yi = gauspuls(t,50e3,0.6); 
plot(t,yi)

%%%%%%%%%%%%%%%%%%% The pulse tran function %%%%%%%%%%%%%%%%%%%%%%%%%

T = 0:1/50E3:10E-3;
D = [0:1/1E3:10E-3;0.8.^(0:10)]';
Y = pulstran(T,D,'gauspuls',10E3,0.5);
plot(T,Y)


%%%%%%%%%%%%%%%%%% the chirp function %%%%%%%%%%%%%%%%%%%

t = 0:1/1000:2;
y = chirp(t,0,1,150);

%To plot the spectrogram, use


spectrogram(y,256,250,256,1000,'yaxis')

%%%%%%%%%%%%%%%%% the sinc function %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x = linspace(-5,5);
y = sinc(x);
plot(x,y)


%%%%%%%%%%%%%%%%%%%%%%% the diric function %%%%%%%%%%%%%%%%%%%

x = linspace(0,4*pi,300);
figure,plot(x,diric(x,7)); 
figure,plot(x,diric(x,8)); 

%%%%%%%%%%%%%%%%%%%%%%% 
