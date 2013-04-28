function [im_vector] = mask_image(filepath)
    mask = load('mask.mat');
    mask = mask.mask;
    unmasked_pixels = find(mask);
    image = imread(filepath);
    im_vector = image(unmasked_pixels);
    
    %full_im = zeros(size(mask));
    %full_im(unmasked_pixels) = im_vector;
    %masked_image = full_im;
end