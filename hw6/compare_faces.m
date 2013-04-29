function [] = compare_faces(i, num)
num_eigenfaces = 10;
if nargin > 1
    num_eigenfaces = num;
end
disp(sprintf('Using %i eigenfaces', num_eigenfaces));
[evecs, evals] = get_eigenfaces('CelebrityDatabase', num_eigenfaces);
image_mat = build_image_mat('CelebrityDatabase');
reconstruct_image(evecs, mean(image_mat), image_mat(i,:), true);

end