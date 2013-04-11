function [ entropy ] = compute_entropy( frac )
%COMPUTE_ENTROPY Summary of this function goes here
%   Detailed explanation goes here
if frac == 0 || frac == 1
    entropy = 0;
else
    entropy = - frac * log(frac) - (1 - frac) * log(1 - frac);
end
end

