[errrates, num_training, confmats] = runner('', '', '', '');
h = plot(num_training, errrates);
title('Err Rate as a function of Num Training Examples');
xlabel('Num Training Examples');
ylabel('Err Rate (%)');
text(num_training(3), errrates(3)+.02, '\downarrow defaultopts', 'HorizontalAlignment', 'left');

[errrates, num_training, confmats] = runner(3.9e-7, 1000, 2, '');
hold all
plot(num_training, errrates);
text(num_training(4), errrates(4)-.02, '\uparrow -c 3.9e-7 -B 1000 -s 2');