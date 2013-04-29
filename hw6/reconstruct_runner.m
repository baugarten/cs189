function [error] = reconstruct_runner(k, image_mat)
    mean_im = mean(image_mat);
    [eigenfaces, eigenvalues] = get_eigenfaces('CelebrityDatabase', k);
    err = 0;
    for i=1:size(image_mat)
        im = reconstruct_image(eigenfaces, mean_im, image_mat(i,:));
        tmperr = im - image_mat(i,:);
        err = err + sum(tmperr .^ 2);
    end
    error = err;
end