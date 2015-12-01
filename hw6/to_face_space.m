function [face_space_imgs] = to_face_space(imgs, efaces) 
    face_space_imgs = zeros(size(imgs, 1), size(efaces, 1));
    for i=1:size(efaces, 1)
        face_space_imgs(:, i) = efaces(i,:) * transpose(imgs);
    end
end