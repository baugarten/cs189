function [ entropy ] = compute_entropy( frac )
%COMPUTE_ENTROPY Summary of this function goes here
%   Detailed explanation goes here
entropy = - frac .* log(frac) - (1 - frac) .* log(1 - frac);
% Correct the limit case (0 or 1) by replacing NaNs with 0
entropy(isnan(entropy)) = 0;
end

