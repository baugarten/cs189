
function impurity = entropy_impurity_strategy(x, y)
  spam_count = sum(labels);
  total = size(labels, 1);

  impurity = - ((total-spam_count)/total*log((total-spam_count)/total) + ...
            ((spam_count/total) * log(spam_count/total)));
end
