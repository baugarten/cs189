[eigenfaces, eigenvalues] = get_eigenfaces('CelebrityDatabase', 10);
    
mask = load('mask.mat');
mask = mask.mask;
unmasked_pixels = find(mask);

for i=1:10
    im_pixels = eigenfaces(i,:);
    figure;
    imagesc(unmask_image(mask, im_pixels));
end