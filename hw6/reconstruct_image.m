function [] = reconstruct_image(eigenfaces, eigenvalues, mean, image)
    mask = load('mask.mat');
    mask = mask.mask;
    reconst_image = mean; % reconstructed image
    deviation = image - mean;
    for i=1:size(eigenfaces, 1)
        size(deviation)
        size(eigenfaces(i,:))
        dot(deviation, eigenfaces(i,:))
        a_i = dot(deviation, eigenfaces(i,:)); % get a dot product
        reconst_image = reconst_image + a_i * eigenfaces(i,:);
    end
    im = unmask_image(mask, reconst_image);
    imagesc(im ./ max(im(:)));
    figure
    imagesc(unmask_image(mask, image));
end