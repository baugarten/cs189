image_mat = build_image_mat('CelebrityDatabase');
trials = 1:10:150;
errs = zeros(1, size(trials, 2));
for i=1:size(trials, 2)
    num = trials(:,i);
    disp(sprintf('Getting err for %i faces', num));
    errs(i) = reconstruct_runner(num,image_mat);
end

plot(trials, errs);

