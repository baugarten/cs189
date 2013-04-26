function [masked_image] = mask_image(filepath)
    unmasked_pixels = find(mask);
    image = imread(filepath);
    im_vector = image(unmasked_pixels);
    full_im = zeros(size(mask));
    full_im(unmasked_pixels) = im_vector;
    masked_image = full_im;
end