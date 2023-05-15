function sample_seq = GenerateSamples(bit_seq,fs)
%
% Inputs:
%   bit_seq:    Input bit sequence
%   fs:         Number of samples per bit
% Outputs:
%   sample_seq: The resultant sequence of samples
%
% This function takes a sequence of bits and generates a sequence of
% samples as per the input number of samples per bit

sample_seq = zeros(size(bit_seq*fs));

%%% WRITE YOUR CODE FOR PART 2 HERE

% we generate neested loop
% outter loop from 1 to length(bit_seq) for input bit_seq
% inner loop from 1 to fs to repeat each input bit fs times
% for ex: fs = 5
% i = 1
% sample_seq(0 + 1) =  bit_seq(1)
% sample_seq(0 + 2) =  bit_seq(1)
% sample_seq(0 + 3) =  bit_seq(1)
% sample_seq(0 + 4) =  bit_seq(1)
% sample_seq(0 + 5) =  bit_seq(1)
% i = 2
% sample_seq(1 * 5 + 1) =  bit_seq(2)
% sample_seq(1 * 5 + 2) =  bit_seq(2) and so on
for i = 1 : length(bit_seq)
    for j = 1 : fs
        sample_seq((i - 1) * fs + j) =  bit_seq(i);
    end
end

%%%