function [eigenfaces] = get_eigenfaces(directory)
    image_mat = build_image_mat(directory);
    T = bsxfun(@minus, image_mat, mean(image_mat));
    T_transT = T*T';
    size(T)
    size(T_transT)
    [eigenvectors, eigenvalues] = eig(T_transT);
    size(eigenvalues(:))
    eigenvalues_arr = diag(eigenvalues);
    [sortedValues, sortIndex] = sort(eigenvalues_arr, 'descend');
    maxIndex = sortIndex(1:10);
    eigenvalues_arr(maxIndex)
    eigenvectors(:,maxIndex)
    size(image_mat(maxIndex,:))
    
    
    mask = load('mask.mat');
    mask = mask.mask;
    unmasked_pixels = find(mask);
    top_eigenfaces = image_mat(maxIndex,:);
    for i=1:size(top_eigenfaces)
        im_pixels = top_eigenfaces(i,:);
        full_im = zeros(size(mask));
        full_im(unmasked_pixels) = im_pixels;
        imagesc(full_im ./ 255);
        figure;
    end
    
%    eigenvectors(maxIndex,:)
    
end