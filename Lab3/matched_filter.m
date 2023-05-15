clear
clc
% Define the transmitted binary sequence
seq_len = 1e5; % sequence length
transmitted_bits = randi([0 1], 1, seq_len); % randomly generated binary sequence
BER = [];
% Define the waveform shape and its duration
m = 20; % Number of samples that represents waveform
SNR=0:2:30; 
a = input(sprintf('Enter the amplitude of S1 waveform ')); % Amplitude of S1
b = input(sprintf('Enter the amplitude of S2 waveform ')); % Amplitude of S2
S1 = a*ones(1, m); % waveform that represents 1
S2 = b*ones(1, m); % waveform that represents 0

transmitted_signal = zeros(1,m*seq_len); %preallocation
% Mapping each bit to its waveform to be transmitted
for i = 0:length(transmitted_bits)-1 
    if transmitted_bits(i+1) == 1          
        val = S1;    
    else         
        val = S2;                            
    end
    transmitted_signal((m*i)+1:m*i+length(val)) = val; 
end


% Flip the pulse waveform to obtain the filter kernel
h = fliplr(S1) - fliplr(S2);

recovered_bits = length(transmitted_bits); % preallocation
filtered_signal = zeros(1,m*seq_len); %preallocation

for SNR_dB = 0:2:30
    % Add AWGN to the transmitted signal
    received_signal = awgn(transmitted_signal, SNR_dB, 'measured');

    % Convolve the received signal with the filter kernel
    for i = 0 : 1 : (length(received_signal)-m)/m
        filtered_signal((i*2*m - i*1)+1:(i*2*m - i*1)+ (2*m-1)) = conv(received_signal((i*m)+1:(i*m)+m), h);
    end
    
    % Perform threshold detection on the filtered signal to recover the binary sequence
    threshold = sum(filtered_signal)/length(filtered_signal); % detection threshold
    for i = 1 : 1 : length(filtered_signal)/(2*m-1)
        recovered_bits(i) = (filtered_signal(floor(i*(2*m-1) - (2*m-1)/2)) >= threshold);
    end
    % Compute the bit error rate
    BER = [BER sum(xor(transmitted_bits, recovered_bits))/seq_len]; % bit error rate
    
end

%Plot the signals
% figure
% subplot(5,1,1);
% stem(transmitted_bits);
% title('Transmitted bits');
% subplot(5,1,2);
% plot(transmitted_signal);
% title('Transmitted signal');
% subplot(5,1,3);
% plot(received_signal);
% title('Received signal');
% subplot(5,1,4);
% plot(filtered_signal);
% title('Filtered signal');
% subplot(5,1,5);
% stem(recovered_bits);
% title(sprintf('Recovered bits (BER = %0.3g)', BER));

% Plot SNR versus BER
figure;
semilogy(SNR, BER,'g')
hold on
xlabel('SNR')
ylabel('BER')


