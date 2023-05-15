function bit_seq = GenerateBits(N_bits)
%
% Inputs:
%   N_bits:     Number of bits in the sequence
% Outputs:
%   bit_seq:    The sequence of generated bits
%
% This function generates a sequence of bits with length equal to N_bits

bit_seq = zeros(1,N_bits);
%%% WRITE YOUR CODE HERE

% randi([imin,imax], sz1, sz2) function returns an array containing integers drawn from 
% the discrete uniform distribution on the interval [imin,imax] with dims sz1*sz2
% So, randi([0 1], 1, N_bits) returns an array of size 1 * N_bits of random
% values of 0's and 1's 

bit_seq = randi([0 1], 1, N_bits); 

%%%