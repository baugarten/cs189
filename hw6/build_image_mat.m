function [image_mat] = build_image_mat(directory)
    files = dir(strcat(directory, '/*.jpg'));
    image_mat = zeros(size(files, 1), 51951); % 277200 = size of im_vector
    size(files, 1)
    for i=1:size(files, 1)
        image_mat(i,:) = mask_image(strcat(dir, '/', files(i).name));
    end
end