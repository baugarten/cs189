function result = num_points_predicate(x, y)
  if (size(x, 1) > 100)
    result = true;
  else
    result = false;
  end
end
