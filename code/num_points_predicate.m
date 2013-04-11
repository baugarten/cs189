function result = num_points_predicate(x, y)
  if (size(x, 1) > 5)
    result = true;
  else
    result = false;
  end
end
