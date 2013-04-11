
function impurity = entropy_impurity_strategy(x, y)
  spam_count = sum(y);
  total = size(y, 1);

  impurity = - ((total-spam_count)/total*log((total-spam_count)/total) + ...
            ((spam_count/total) * log(spam_count/total)));
end
