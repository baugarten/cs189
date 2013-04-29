[eigenfaces, eigenvalues] = get_eigenfaces('CelebrityDatabase', 10);
    
mask = load('mask.mat');
mask = mask.mask;
unmasked_pixels = find(mask);

for i=1:10
    im_pixels = eigenfaces(i,:);
    if sum(im_pixels(:) < 0) > 0
        disp('Adding min value');
        disp(num2str(min(im_pixels(:))));
        im_pixels(:) = im_pixels(:) + abs(min(im_pixels(:)));
        disp(num2str(min(im_pixels(:))));
    end
    im_pixels = im_pixels ./ max(im_pixels);
    figure;
    sum(im_pixels < 0)
    imagesc(unmask_image(mask, im_pixels));
end