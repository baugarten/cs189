function [best_match, second_match] = euclidean_dist(index, vis) 
    img_mat = build_image_mat('CelebrityDatabase');
    T = bsxfun(@minus, img_mat, mean(img_mat));
    student_img_mat = build_image_mat('StudentDatabase');
    student_image = student_img_mat(index,:);
    norm_student_image = student_image - mean(student_img_mat);
    
    [efaces, evals] = get_eigenfaces('CelebrityDatabase', 10);
    
    face_space_imgs = to_face_space(T, efaces);
    face_space_student_img = to_face_space(norm_student_image, efaces);

    best = zeros(2, size(img_mat, 2));
    [k, D] = knnsearch(face_space_imgs, face_space_student_img, 'K', 2);
    best_match = img_mat(k(1),:);
    second_match = img_mat(k(2),:);
    
    if nargin > 1 && vis
        mask = load('mask');
        mask = mask.mask;
        figure;
        imagesc(unmask_image(mask, student_image) ./ 255);
        figure;
        imagesc(unmask_image(mask, best_match) ./ 255);
        figure;
        imagesc(unmask_image(mask, second_match) ./ 255);
    end
end