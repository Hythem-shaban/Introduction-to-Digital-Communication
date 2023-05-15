function rec_sample_seq  = BSC(sample_seq,fs,p,channel_type)
%
% Inputs:
%   sample_seq:     The input sample sequence to the channel
%   fs:             The sampling frequency used to generate the sample sequence
%   p:              The bit flipping probability
%   channel_type:   The type of channel, 'independent' or 'correlated'
% Outputs:
%   rec_sample_seq: The sequence of sample sequence after passing through the channel
%
% This function takes the sample sequence passing through the channel, and
% generates the output sample sequence based on the specified channel type
% and parameters

% I think ~~ is not valuable!
sample_seq      = ~~sample_seq;
rec_sample_seq  = zeros(size(sample_seq));
rec_sample_seq  = ~~rec_sample_seq;

if (nargin <= 3)
    channel_type = 'independent';
end

switch channel_type
    
    case 'independent'
        % rand(n) function returns an array of size n in the range from 0
        % to 1
        % here we compare each element of the generated random array with
        % the probability of fliping 
        % if the element is less than or equal to p (with prob p) then the 
        % output of the channel should be flipped
        % if the element is greater than p (with prob 1-p) then the output
        % of the channel should be the same as input
        channel_effect = rand(size(rec_sample_seq))<=p;
    case 'correlated'
        % rand(n) function returns an array of size n in the range from 0
        % to 1
        % here the correlated channel has an input from the Tx with
        % repeatation of fs and correlated outputs among the 5 
        % transmitter outputs that correspond to the same input bit
        % repmat(channel_effect, fs, 1) is a function that returns a
        % repeated version of array channel_effect with size fs*1
        % channel_effect(:)' is used to transpose to 1*fs vector
        channel_effect = rand(1,length(rec_sample_seq)/fs)<=p;
        channel_effect = repmat(channel_effect,fs,1);
        channel_effect = channel_effect(:)';
end
% here we xor between input bit_seq and the channel_effect
% if out is 1 it means that bit_seq and channel_effect are difference so
% flipping is occurred 
% if out is 0 it means that bit_seq and channel_effect are similar so
% no change
rec_sample_seq = xor(sample_seq,channel_effect);
% I think + 0 is not valuable!
rec_sample_seq = rec_sample_seq + 0;
