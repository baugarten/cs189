function [unmasked] = unmask_image(mask, image)
    unmasked_pixels = find(mask);
    full_im = zeros(size(mask));
    full_im(unmasked_pixels) = image;
    unmasked = full_im;
end