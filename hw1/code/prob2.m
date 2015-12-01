function prob2(i)

[errrates, num_training, confmats] = runner('', '', '', '');

if nargin > 0
    confmats(:,:,i)
    figure
    imagesc(confmats(:,:,i));
else
    for i=1:7
        figure
        imagesc(confmats(:,:,i));
    end
end