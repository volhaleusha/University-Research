function [CIR_left, CIR_right] = get_CIR(pl1_left, pl1_right, pl2_left, pl2_right)
    nodes = length(pl1_left);

    for i = 1:nodes
        for j = 1:nodes
            CIR_left(i,j)= pl2_left(j) - pl1_left(i);
            CIR_right(i,j)= pl1_right(j) - pl2_right(i);
        end
    end