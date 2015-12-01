c = .0000000001;
b = 0
maxc = c;
maxb = b;
maxs = -1;
maxaccuracy = 0;
accuracies = zeros(3);

possibs = [2]; %[0,1,2,3,4,5,6,7];
while c < 100000000 && b < 100000000
    while b < 10000000000
        for s=possibs

            c
            b
            s
            [g, garb, accuracies, garb2] = trainer(2, num2str(c), num2str(b), num2str(s));
            
            if (accuracies(1) > maxaccuracy)
                maxaccuracy = accuracies(1);
                maxc = c;
                maxb = b;
                maxs = s;
            end
        end
        if b == 0 
            b = 1
        end
        b = b * 10;
    end
    c = c * 10;    
    b = 0
end

maxaccuracy
maxc
maxb
maxs
