function result = num_points_predicate(x, y)
  if (size(x, 1) > 100)
    result = true;
  else
    disp('No more splitting here');
    result = false;
  end
end
