function [ entropy ] = compute_entropy( frac, method )
%COMPUTE_ENTROPY Summary of this function goes here
%   Detailed explanation goes here
if nargin < 2 || strcmpi(method, 'entropy')
    entropy = - frac .* log(frac) - (1 - frac) .* log(1 - frac);
elseif strcmpi(method, 'variance')
    entropy = frac .* (1 - frac);
elseif strcmpi(method, 'misclassification')
    entropy = 1 - max(frac, (1 - frac));
end
%entropy = - frac .* log(frac) - (1 - frac) .* log(1 - frac);
% Correct the limit case (0 or 1) by replacing NaNs with 0
entropy(isnan(entropy)) = 0;
end

