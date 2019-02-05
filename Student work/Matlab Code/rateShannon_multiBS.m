function r = rateShannon_multiBS(CIR_fap, B)
    CIR_l=10.^(CIR_fap./10);
    r=B.*log2(1+CIR_l);
    
    

    
    