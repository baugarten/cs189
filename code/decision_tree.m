% @author       Ben, Rich, Max
% @assignment   CS189 HW5

% @params
%   - data: data points to be split
%   - stopping_opt: stopping criteria
%   - split_opt: splitting criteria
function [] = decision_tree(data, stopping_opt, split_opt)
    % if stopping criteria not met
        % sort all by all features
        % calculate entropies (or more generally splitting criteria)
        % split on greatest reduction
        % decision_tree on both halves

    % One question is how do we store the tree?  One option is as an array
    % (hilfinger did this).  0's children are 1 and 2.  1's children are 3 and
    % 4.  2's children are 5 and 6.  3's children are 7 and 8, and so on.
    % Space-wise this is pretty wasteful though, as the tree probably won't
    % be complete.  Any other ideas?
end
