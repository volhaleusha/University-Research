maxNodes = 10;

xesCIR = -50:0.1:100;
histGrCIR = zeros(1, length(xesCIR));
histMaxRegCIR = zeros(1, length(xesCIR));
histRCIR = zeros(1, length(xesCIR));

xesThrLTE = 0:20000:4E7;
xesThrSh = 0:20000:20E7;

histGrThrLTE = zeros(1, length(xesThrLTE));
histMaxRegThrLTE = zeros(1, length(xesThrLTE));
histMaxRegUserThrLTE = zeros(1, length(xesThrLTE));
histRThrLTE = zeros(1, length(xesThrLTE));
histRThrLTE_repeat = zeros(1, length(xesThrLTE));
histOptimalThrLTE = zeros(1, length(xesThrLTE));
histOptimalThrLTE_Brute = zeros(1, length(xesThrLTE));

winner_Gr = 0;
winner_Rand = 0;
winner_MaxReg = 0;
winner_MaxRegUser = 0;


histGrThrSh = zeros(1, length(xesThrSh));
histMaxRegThrSh = zeros(1, length(xesThrSh));
histMaxRegUserThrSh = zeros(1, length(xesThrSh));
histRThrSh = zeros(1, length(xesThrSh));


for d = 8; %:maxNodes
    
    % Nodes per system (UTs for each BS)
    nodes = d;
    % Number of BS
    
    faps= 4;  
    rcell=100;
    dinter=-50;
    rinter =2*dinter;
    
    k='4FAPs';

    % Number of drops with different node positions in each drop
    drops = 1000;

    B=17.28E6;
    
    seGrLTE = 0;
    seRand_LTE = 0;
    seRand_LTE_repeat =0;
    seMaxReg_LTE = 0;
    seMaxRegUser_LTE = 0;
    seOptimal_LTE = 0;
    seOptimal_LTE_Brute = 0;
    seGrSh = 0;
    seRand_Sh = 0;
    seMaxReg_Sh = 0;
    seMaxRegUser_Sh = 0;
    pl1=0;
    dist1=0;
    
    tic
    for i = 1:drops
        i
        if mod(i, 10) == 0
            i / drops  * 100
        end
        

        % Get coordinates for each Base Station (faps is number of base
        % stations)
        
        [xfap, yfap]= get_FAPs_coord (faps, rcell, rinter);
        
        % Get node positions for both systems
        
        [x, y] = get_InH_UTs_multiBS(nodes, xfap, yfap, rcell, faps);       
%         plot(x(:),y(:),'*')
%         axis equal;
        
        % Get the distances of each node to each BS and from there the
        % pathlosses
        
        [distance]= get_distance_multiBS(x, y, xfap, yfap, faps);
        
        % Get pathloss for each UT and BS combination:
        
        pl = get_path_loss_multiBS(distance, 'nlos');
% 
%         pl1=pl1+(sum(sum(sum(pl/d))/(faps^2)))/drops;
%         dist1=dist1+(sum(sum(sum(distance/d)))/(faps^2))/drops;
%         
%     end        
%     pl1
%     dist1
    
    
      % Get CIR for each system and each combination (possible variations-
      % 2FAPs, 3FAPs, 4FAPs)
       
       [CIR_fap, CIR_common] = get_CIR_multiBS(pl, nodes,k);
      
       thrLTE_fap = rateLTE_multiBS(CIR_fap,k)./nodes;
       thrLTE_common = get_common_multiBS(thrLTE_fap, nodes,k);


       optRand_LTE = get_entries_random_multiBS(thrLTE_fap, thrLTE_common, k);

       optGr_LTE = get_entries_greedy_multiBS(thrLTE_fap, thrLTE_common, k);   

       opt_common_old=0;
      
       for m=1:1000
           
        optRand_LTE_test= get_entries_random_multiBS(thrLTE_fap, thrLTE_common, k);
        opt_common = sum(optRand_LTE_test);
        if opt_common >= opt_common_old
              optRand_LTE_repeat = optRand_LTE_test;
              opt_common_old = opt_common;
        end 
       end
       
    
       

       seGrLTE = seGrLTE + sum(optGr_LTE) ./ (faps * B);
       seRand_LTE = seRand_LTE + sum(optRand_LTE) ./ (faps * B);
       seRand_LTE_repeat = seRand_LTE_repeat + sum(optRand_LTE_repeat) ./ (faps * B);
    
       s1(i) = sum(optGr_LTE) ./ (faps * B);
       s2(i) = sum(optRand_LTE) ./ (faps * B);
       s3(i) = sum(optRand_LTE_repeat) ./ (faps * B);
 
  
    end
    toc
   
      % confidence interval for 95%:
       cl=0.95;
       conf_Gr = get_confidence(s1, cl,drops);    
       conf_RTh = get_confidence(s2, cl,drops);
       conf_RThr = get_confidence(s3, cl,drops);
     
       seGrLTE_d_d(d) = seGrLTE ./ drops;
       
       seRand_LTE_repeat_d_d(d) = seRand_LTE_repeat ./ drops;
    
       
       seGrLTE_d = seGrLTE ./ drops;
       seRand_LTE_d = seRand_LTE ./ drops;
       seRand_LTE_repeat_d = seRand_LTE_repeat ./ drops;
      
  end



a= [seGrLTE_d,  seRand_LTE_repeat_d]
