function [eigenfaces, eigenvalues] = get_eigenfaces(directory, top_k)
    image_mat = build_image_mat(directory);
    T = bsxfun(@minus, image_mat, mean(image_mat));
    T_transT = T*T';
    [eigenfaces, eigenvalues] = eig(T_transT);
    
    if nargin > 1
        eigenvalues_arr = diag(eigenvalues);
        [sortedValues, sortIndex] = sort(eigenvalues_arr, 'descend');
        maxIndex = sortIndex(1:top_k);

        
        eigenfaces = image_mat(maxIndex,:);
        eigenvalues = diag(eigenvalues_arr(maxIndex));
        
        
    
%    eigenvectors(maxIndex,:)
    
end