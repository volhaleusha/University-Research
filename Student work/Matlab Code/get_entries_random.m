function opt = get_entries_random(mat1, mat2)
    TR = mat1 + mat2';
    r = [];
    r = randperm(size(TR, 1));

    for i =1:size(TR, 1)
        opt(i) = mat1(i, r(i));
        opt(i + size(TR, 1))=mat2(r(i), i);
    end
