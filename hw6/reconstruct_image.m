function [im] = reconstruct_image(eigenfaces, mean, image, vis)
    mask = load('mask.mat');
    mask = mask.mask;
    %reconst_image = mean; % reconstructed image
    reconst_image = zeros(1, size(eigenfaces(1,:), 1));
    deviation = image - mean;
    
    for i=1:size(eigenfaces, 1)
        a_i = dot(deviation, eigenfaces(i,:)); % get a dot product
        reconst_image = reconst_image + a_i * eigenfaces(i,:);
    end

    reconst_image = reconst_image + mean;
    im = reconst_image;
    if nargin > 3 && vis
        %figure
        %imagesc(unmask_image(mask, mean) ./ 255);
        if sum(reconst_image(:) < 0) > 0
            disp('Adding min value');
            disp(num2str(min(reconst_image(:))));
            reconst_image(:) = reconst_image(:) + abs(min(reconst_image(:)));
            disp(num2str(min(reconst_image(:))));
        end
        reconst_image = reconst_image ./ max(reconst_image);
        im = unmask_image(mask, reconst_image);
        sum(im(:) < 0)
        figure
        imagesc(im);
        figure
        unmasked = unmask_image(mask, image);
        imagesc(unmasked ./ 255);
    end
end