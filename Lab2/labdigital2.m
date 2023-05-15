%%
clear
clc
% reconstruction from oversampling (1000>>2*5)
t=0:0.001:1;% time signal
y=2*cos(2*pi*5*t);

[B,A] = butter(3,1000/100000,'low' ); % butter fly filter n-> order / wn-> normalized cutoff freq / type-> low/high/stop/pass
%A and B -> transfer function coefficient
zero_added_signal=zeros(1,length(y)*10);
for i=1:length(y)
zero_added_signal(i*10)=y(i);
end
zero_added_signal(1:9)=[];


% Adding zeros enhances the signal display and don't change the
%spectrum,it changes sampling freq. only
t=linspace(0,1,length(zero_added_signal));
filtered_signal = filter(B,A,zero_added_signal);
figure;
plot(t,filtered_signal,'r' )
%%
q = quantizer('fixed','convergent','wrap',[6 7]);
filtered_signal=quantize(q,filtered_signal); %quantizer creates a quantizer object with properties set to their default values. To use this object to quantize values, use the quantize method.
figure;
plot(t,filtered_signal,'black')

filtered_signal = filter(B,A,zero_added_signal);
companded_signal=compand(filtered_signal,255,max(filtered_signal),'mu/compressor');
companded_signal=compand(companded_signal,255,max(companded_signal),'mu/expander');
figure;
plot(t,companded_signal)
 
%% 
% construction from minimum sampling

t=0:0.1:1; % replace ?? with the suitable number. 0.1 is the reciprocal of Nyquist rate 10 = 2*5
y=2*cos(2*pi*5*t);
[B,A] = butter(10,0.1,'low' );
zero_added_signal=zeros(1,length(y)*10);
for i=1:length(y)
zero_added_signal(i*10)=y(i);
end
zero_added_signal(1:9)=[];

t=linspace(0,1,length(zero_added_signal));

filtered_signal = filter(B,A,zero_added_signal);
plot(t,filtered_signal,'r' )
xlabel('time')
ylabel('minimum sampled signals')
%%
s=fft(filtered_signal);
s=fftshift(s);
fs=100; % why 100?? after sampling by Nyquist rate=10 , we interpolate by f=10. hence, we sample as if sampling rate = 100.
freq=linspace(-fs/2,fs/2,length(s));
figure
plot(freq,abs(s))
xlabel('freq')
ylabel('magnitude of minimum sampled signals')

%% 

% construction from undersampling sampling
figure
t=0:0.2:1;
y=2*cos(2*pi*5*t);
[B,A] = butter(10,0.2,'low' );
zero_added_signal=zeros(1,length(y)*10);
for i=1:length(y)
zero_added_signal(i*10)=y(i);
end
zero_added_signal(1:9)=[];

t=linspace(0,1,length(zero_added_signal));
filtered_signal = filter(B,A,zero_added_signal);
plot(t,filtered_signal,'r' )
xlabel('time')
ylabel('minimum sampled signals')
s=fft(filtered_signal);
s=fftshift(s);
fs=50;
freq=linspace(-fs/2,fs/2,length(s));
figure
plot(freq,abs(s))
xlabel('freq')
ylabel('magnitude of minimum sampled signals')

% complete this part as shown in the construction from minimum sampling
%and do the necessary changes , you have to do low pass filtering and %
