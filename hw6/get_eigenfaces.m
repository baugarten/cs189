function [eigenfaces, eigenvalues] = get_eigenfaces(directory, top_k)
    image_mat = build_image_mat(directory);
    T = bsxfun(@minus, image_mat, mean(image_mat));
    T_transT = T*T';
    [evecs, evals] = eig(T_transT);
    if nargin < 2
        top_k = size(T_transT);
    end

    evals_arr = diag(evals);
    [sortedValues, sortIndex] = sort(evals_arr, 'descend');
    maxIndex = sortIndex(1:top_k);
    top_evecs = evecs(:, end-top_k+1:end);

    eigenfaces = zeros(size(evecs, 2), size(image_mat, 2));
    for i=1:size(evecs, 2)
        eigenfaces(i,:) = T' * evecs(:,i);
    end
    eigenfaces = normc(eigenfaces');
    eigenfaces = eigenfaces';
    eigenvalues = evals;
    
    if nargin > 1
        eigenvalues_arr = diag(eigenvalues);
        [sortedValues, sortIndex] = sort(eigenvalues_arr, 'descend');
        maxIndex = sortIndex(1:top_k);
        
        eigenfaces = eigenfaces(maxIndex,:);
        eigenvalues = diag(eigenvalues_arr(maxIndex));
    end
end