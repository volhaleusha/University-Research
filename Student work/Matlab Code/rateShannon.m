function [r] = rateShannon(CIR, B)
    CIR_l=10.^(CIR./10);
    r=B.*log2(1+CIR_l);