function BER = ComputeBER(bit_seq,rec_bit_seq)
%
% Inputs:
%   bit_seq:     The input bit sequence
%   rec_bit_seq: The output bit sequence
% Outputs:
%   BER:         Computed BER
%
% This function takes the input and output bit sequences and computes the
% BER

%%% WRITE YOUR CODE HERE

wrong_bits = abs(rec_bit_seq - bit_seq);
num_wrong_bits = sum(wrong_bits);
BER = num_wrong_bits / length(bit_seq);

%%%
