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


recovered_bits = length(transmitted_bits); % preallocation
filtered_signal = zeros(1,m*seq_len); %preallocation

for SNR_dB = 0:2:30
    % Add AWGN to the transmitted signal
    received_signal = awgn(transmitted_signal, SNR_dB, 'measured');

    %  Apply element by element multiplication and then add the resultant samples together.
    for i = 0 : 1 : (length(received_signal)-m)/m
        filtered_signal((i*m)+1:(i*m)+m) = sum(received_signal((i*m)+1:(i*m)+m).*conj(S1)) - sum(received_signal((i*m)+1:(i*m)+m).*conj(S2));
    end

    % Perform threshold detection on the filtered signal to recover the binary sequence
    threshold = sum(filtered_signal)/length(filtered_signal); % detection threshold
    for i = 1 : 1 : length(filtered_signal)/m
        recovered_bits(i) = (filtered_signal(i*m) > threshold);
    end
    % Compute the bit error rate
    BER = [BER sum(xor(transmitted_bits, recovered_bits))/seq_len]; % bit error rate
end

% %Plot the signals
% subplot(4,1,1);
% stem(transmitted_bits);
% title('Transmitted bits');
% subplot(4,1,2);
% plot(transmitted_signal);
% title('Transmitted signal');
% subplot(4,1,3);
% plot(filtered_signal);
% title('Received signal');
% subplot(4,1,4);
% stem(recovered_bits);
% title(sprintf('Recovered bits (BER = %0.3g)', BER));

figure;
semilogy(SNR, BER,'r')
xlabel('SNR')
ylabel('BER')