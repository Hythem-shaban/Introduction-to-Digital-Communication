clear
clc
% Generate a random binary data signal
N = 1000; % number of bits
bits = randi([0 1], 1, N);
% Define the line code parameters
Tb = 1; % bit period
fs = 10; % sampling frequency (number of samples per bit)
t = 0:(1/fs):Tb*N-(1/fs); % time vector
%%
for i = 1:length(bits)
    clk((i-1)*fs+1:(2*i-1)*fs/2) = 1;
    clk((2*i-1)*fs/2+1:i*fs) = 0;
end
% Plot the input bits signal
figure
subplot(11,1,1)
plot(t, clk, 'LineWidth', 2);
grid on;

title('clk Signal');
%%
NRZ = zeros(1, fs*N);
% Generate the NRZ line code signal
for i = 1:length(bits)
    if bits(i) == 0
        NRZ((i-1)*fs+1:i*fs) = -1;
    else
        NRZ((i-1)*fs+1:i*fs) = 1;
    end
end

% Plot the NRZ line code signal
subplot(11,1,2)
plot(t, NRZ, 'LineWidth', 2);
grid on;

title('NRZ Line Code');
%%
NRZI = zeros(1, fs*N);
current_state = 1;
% Generate the NRZI line code signal
for i = 1:length(bits)
    if bits(i) == 0
        NRZI((i-1)*fs+1:i*fs) = current_state;
    else
        NRZI((i-1)*fs+1:i*fs) = - current_state;
        current_state = - current_state;
    end
end

% Plot the NRZI line code signal
subplot(11,1,3)
plot(t, NRZI, 'LineWidth', 2);
grid on;

title('NRZI Line Code');
%%
UP_NRZ = zeros(1, fs*N);
% Generate the Unipolar NRZ line code signal
for i = 1:length(bits)
    if bits(i) == 0
        UP_NRZ((i-1)*fs+1:i*fs) = 0;
    else
        UP_NRZ((i-1)*fs+1:i*fs) = 1;
    end
end

% Plot the Unipolar NRZ line code signal
subplot(11,1,4)
plot(t, UP_NRZ, 'LineWidth', 2);
grid on;


title('Unipolar NRZ Line Code');

%%
UP_RZ = zeros(1, fs*N);
% Generate the Unipolar RZ line code signal
for i = 1:length(bits)
    if bits(i) == 0
        UP_RZ((i-1)*fs+1:i*fs) = 0;
    else
        UP_RZ((i-1)*fs+1:(2*i-1)*fs/2) = 1;
        UP_RZ((2*i-1)*fs/2+1:i*fs) = 0;
    end
end

% Plot the Unipolar RZ line code signal
subplot(11,1,5)
plot(t, UP_RZ, 'LineWidth', 2);
grid on;

title('Unipolar RZ Line Code');
%%
P_NRZ = zeros(1, fs*N);
% Generate the Polar NRZ line code signal
for i = 1:length(bits)
    if bits(i) == 0
        P_NRZ((i-1)*fs+1:i*fs) = -1;
    else
        P_NRZ((i-1)*fs+1:i*fs) = 1;
    end
end

% Plot the Polar NRZ line code signal
subplot(11,1,6)
plot(t, P_NRZ, 'LineWidth', 2);
grid on;


title('Polar NRZ Line Code');
%%
P_RZ = zeros(1, fs*N);
% Generate the Polar RZ line code signal
for i = 1:length(bits)
    if bits(i) == 0
        P_RZ((i-1)*fs+1:(2*i-1)*fs/2) = -1;
        P_RZ((2*i-1)*fs/2+1:i*fs) = 0;
    else
        P_RZ((i-1)*fs+1:(2*i-1)*fs/2) = 1;
        P_RZ((2*i-1)*fs/2+1:i*fs) = 0;
    end
end

% Plot the Polar RZ line code signal
subplot(11,1,7)
plot(t, P_RZ, 'LineWidth', 2);
grid on;


title('Polar RZ Line Code');
%%
BiP_NRZ = zeros(1, fs*N);
flag = 0;
% Generate the Bipolar NRZ (AMI) line code signal
for i = 1:length(bits)
    if bits(i) == 0
        BiP_NRZ((i-1)*fs+1:i*fs) = 0;
    else
        if flag == 0
            BiP_NRZ((i-1)*fs+1:i*fs) = 1;
            flag = 1;
        else
            BiP_NRZ((i-1)*fs+1:i*fs) = -1;
            flag = 0;
        end
    end
end

% Plot the Bipolar NRZ (AMI) line code signal
subplot(11,1,8)
plot(t, BiP_NRZ, 'LineWidth', 2);
grid on;


title('Bipolar NRZ (AMI) Line Code');
%%
BiP_RZ = zeros(1, fs*N);
flag = 0;
% Generate the Bipolar RZ (AMI) line code signal
for i = 1:length(bits)
    if bits(i) == 0
        BiP_RZ((i-1)*fs+1:i*fs) = 0;
    else
        if flag == 0
            BiP_RZ((i-1)*fs+1:(2*i-1)*fs/2) = 1;
            BiP_RZ((2*i-1)*fs/2+1:i*fs) = 0;
            flag = 1;
        else
            BiP_RZ((i-1)*fs+1:(2*i-1)*fs/2) = -1;
            BiP_RZ((2*i-1)*fs/2+1:i*fs) = 0;
            flag = 0;
        end
    end
end

% Plot the Bipolar RZ (AMI) line code signal
subplot(11,1,9)
plot(t, BiP_RZ, 'LineWidth', 2);
grid on;


title('Bipolar NRZ (AMI) Line Code');
%%
Manchester = zeros(1, fs*N); % preallocate the code signal
% Generate the Manchester line code signal
for i = 1:length(bits)
    if bits(i) == 0
        Manchester((i-1)*fs+1:(2*i-1)*fs/2) = -1;
        Manchester((2*i-1)*fs/2+1:i*fs) = 1;
    else
        Manchester((i-1)*fs+1:(2*i-1)*fs/2) = 1;
        Manchester((2*i-1)*fs/2+1:i*fs) = -1;
    end
end

% Plot the Manchester line code signal
subplot(11,1,10)
plot(t, Manchester, 'LineWidth', 2);
grid on;


title('Manchester Line Code');
%%
MultiLevel_Trans = zeros(1, fs*N);
prev_level = 0;
flag = 0;
% Generate the Multi-Level Transmission 3 line code signal
for i = 1:length(bits)
    if bits(i) == 0
        MultiLevel_Trans((i-1)*fs+1:i*fs)= prev_level;
        prev_level = MultiLevel_Trans(i*fs);
    else
        if prev_level == -1
            next_level = 0;
            flag = 0;
        elseif prev_level == 1
            next_level = 0;
            flag = 1;
        else
            if flag == 0
                next_level = 1;
                flag = 1;
            else
                next_level = -1;
                flag = 0;
            end
        end
        MultiLevel_Trans((i-1)*fs+1:i*fs)= next_level;
        prev_level = next_level;
    end
end

% Plot the Multi-Level Transmission 3 line code signal
subplot(11,1,11)
plot(t, MultiLevel_Trans, 'LineWidth', 2);
grid on;

title('Multi-Level Transmission 3 Line Code');
%%
% h = spectrum.welch;
% input_bits_psd = psd(h, input_bits, 'Fs', 10);
% handle1 = plot(input_bits_psd);

% window_length = N;
% overlap = window_length/2;
% % Calculate the PSD using the Welch method
% [input_bits_psd, f] = pwelch(input_bits, window_length, overlap, [], fs);
% 
% % Plot the PSD
% subplot(8,2,2)
% figure
% plot(f, 10*log10(input_bits_psd));
% xlabel('Frequency');
% ylabel('Power/frequency (dB/Hz)');
% title('Power Spectral Density');
%%
%PSD of NRZ

% Calculate the PSD using the Welch method
[NRZ_psd, f] = pwelch(NRZ);

% Plot the PSD
figure
subplot(5,1,1)
plot(2*f,(NRZ_psd)./100,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of NRZ');
%%
%PSD of NRZI

% Calculate the PSD using the Welch method
[NRZI_psd, f] = pwelch(NRZI);

% Plot the PSD
subplot(5,1,2)
plot(2*f,(NRZI_psd)./100,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of NRZI');
%%
%PSD of Unipolar NRZ

% Calculate the PSD using the Welch method
[UP_NRZ_psd, f] = pwelch(UP_NRZ);

% Plot the PSD
subplot(5,1,3)
plot(2*f,(UP_NRZ_psd)./1000,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of Unipolar NRZ');
%%
%PSD of Unipolar RZ

% Calculate the PSD using the Welch method
[UP_RZ_psd, f] = pwelch(UP_RZ);

% Plot the PSD
subplot(5,1,4)
plot(2*f, (UP_RZ_psd)./1000,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of Unipolar RZ');
%%
%PSD of Polar NRZ

% Calculate the PSD using the Welch method
[P_NRZ_psd, f] = pwelch(P_NRZ);

% Plot the PSD
subplot(5,1,5)
plot(2*f,(P_NRZ_psd)./10,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of Polar NRZ');
%%
%PSD of Polar RZ

% Calculate the PSD using the Welch method
[P_RZ_psd, f] = pwelch(P_RZ);

% Plot the PSD
figure
subplot(5,1,1)
plot(2*f,(P_RZ_psd)./10,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of Polar RZ');
%%
%PSD of Bipolar NRZ AMI

% Calculate the PSD using the Welch method
[BiP_NRZ_psd, f] = pwelch(BiP_NRZ);

% Plot the PSD
subplot(5,1,2)
plot(2*f,(BiP_NRZ_psd)./10,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of Bipolar NRZ AMI');
%%
%PSD of Bipolar RZ AMI

% Calculate the PSD using the Welch method
[BiP_RZ_psd, f] = pwelch(BiP_RZ);

% Plot the PSD
subplot(5,1,3)
plot(2*f,(BiP_RZ_psd)./10,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of Bipolar RZ AMI');
%%
%PSD of Manchester

% Calculate the PSD using the Welch method
[Manchester_psd, f] = pwelch(Manchester);
% Plot the PSD
subplot(5,1,4)
plot(2*f, (Manchester_psd)./10,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of Manchester');
%%
%PSD of MLT-3

% Calculate the PSD using the Welch method
[MultiLevel_Trans_psd, f] = pwelch(MultiLevel_Trans);

% Plot the PSD
subplot(5,1,5)
plot(2*f,(MultiLevel_Trans_psd)./10,'LineWidth', 2);
xlabel('Frequency');
title('Power Spectral Density of MLT-3');
        
        
        
