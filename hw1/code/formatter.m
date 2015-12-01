function [images]=formatter(oldimages, dim)
images1 = zeros(length(oldimages), dim*dim);
for i=1:length(oldimages)
    images1(i,:) = reshape(oldimages(:,:,i), dim*dim, 1);
end
images = sparse(images1);