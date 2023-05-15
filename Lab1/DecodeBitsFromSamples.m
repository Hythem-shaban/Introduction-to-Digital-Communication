function rec_bit_seq = DecodeBitsFromSamples(rec_sample_seq,case_type,p,fs)
%
% Inputs:
%   rec_sample_seq: The input sample sequence to the channel
%   case_type:      The sampling frequency used to generate the sample sequence
%   fs:             The bit flipping probability
% Outputs:
%   rec_sample_seq: The sequence of sample sequence after passing through the channel
%
% This function takes the sample sequence after passing through the
% channel, and decodes from it the sequence of bits based on the considered
% case and the sampling frequence

if (nargin <= 3)
    fs = 1;
end

switch case_type
    
    case 'part_1'
        %%% WRITE YOUR CODE FOR PART 1 HERE
        
        %ex1
        rec_bit_seq = zeros(size(rec_sample_seq));
        %ex2
        %rec_bit_seq = rand(size(rec_sample_seq))<=0.5;
        %best Rx
        % this is the best Rx as it is dependent on the channel output and
        % it states that if the probability of flipping is less than 0.5
        % then it is better that the output of the receiver to be the same
        % as the input of the receiver, and if the probability of flipping 
        % is greater than 0.5 then it is better that the output of the 
        % receiver to be the flipped of the output of the channel
        % for example: if input 1010101010, and with p = 0.2 then the
        % output of the channel might be 1110100010 then it is better that
        % the Rx outputs the same as the output of the channel because
        % there are flippings in two bits only 
        if p <= 0.5
           rec_bit_seq = rec_sample_seq;
        end
        if p > 0.5
            rec_bit_seq = ~rec_sample_seq;
        end
        
        %%%
    case 'part_2'
        %%% WRITE YOUR CODE FOR PART 2 HERE
        
        % first we initilize rec_bit_seq to be the same size as the input
        %seq
        % we generater for loop from 1 to length(rec_sample_seq)/fs
        % output bit is the most frequently value in the fs bits
        % then we use mode function to find most frequently value in the 
        % array within the range from (i-1)*fs+1 to (i-1)*fs+1+(fs-1)
        % for example: if fs = 5 then for first 5 bits (from 1 to 5)
        % rec_bit_seq(1) = mode(rec_sample_seq(1 : 5));
        rec_bit_seq = zeros(size(length(rec_sample_seq)/fs));
        if p <= 0.5
            for i = 1 : length(rec_sample_seq)/fs
                rec_bit_seq(i) = mode(rec_sample_seq((i-1)*fs+1 : (i-1)*fs+1+(fs-1)));
            end
        end
        if p > 0.5
            rec_sample_seq = ~ rec_sample_seq;
            for i = 1 : length(rec_sample_seq)/fs
                rec_bit_seq(i) = mode(rec_sample_seq((i-1)*fs+1 : (i-1)*fs+1+(fs-1)));
            end
        end
        
        %%%
    case 'part_3'
        %%% WRITE YOUR CODE FOR PART 3 HERE
        
        rec_bit_seq = zeros(size(length(rec_sample_seq)/fs));
        if p <= 0.5
            for i = 1 : length(rec_sample_seq)/fs
                rec_bit_seq(i) = mode(rec_sample_seq((i-1)*fs+1 : (i-1)*fs+1+(fs-1)));
            end
        end
        if p > 0.5
            rec_sample_seq = ~ rec_sample_seq;
            for i = 1 : length(rec_sample_seq)/fs
                rec_bit_seq(i) = mode(rec_sample_seq((i-1)*fs+1 : (i-1)*fs+1+(fs-1)));
            end
        end
        
        %%%
end