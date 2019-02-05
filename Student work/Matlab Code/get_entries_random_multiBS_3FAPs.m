function [opt] = get_entries_random_multiBS_3FAPs(fap, common)

    TR = common;
    r = [];
    j = randperm(size(TR, 1));
    k = randperm(size(TR, 1));

    for i =1:size(TR, 1)
        opt(i) = fap(i, j(i),k(i), 1);
        opt(i + size(TR, 1))=fap(j(i), i, k(i), 2);
        opt(i + 2*size(TR, 1))=fap(k(i),i, j(i), 3);
    end
