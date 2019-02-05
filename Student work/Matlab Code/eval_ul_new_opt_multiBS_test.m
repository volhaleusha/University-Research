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
histGrThrSh = zeros(1, length(xesThrSh));
histMaxRegThrSh = zeros(1, length(xesThrSh));
histMaxRegUserThrSh = zeros(1, length(xesThrSh));
histRThrSh = zeros(1, length(xesThrSh));


for d = 3; %:maxNodes
    
    % Nodes per system (UTs for each BS)
    nodes = d;
    % Number of BS
    
    faps= 3;
   
    rcell=250;
    dinter=0;
    rinter =2*dinter;
    
    k='3FAPs';

    % Number of drops with different node positions in each drop
    drops = 1;

    % Channel bandwidth for Shannon capacity
   
    B = 17.28E6;

    seGrLTE = 0;
    seRand_LTE = 0;
    seMaxReg_LTE = 0;
    seMaxRegUser_LTE = 0;
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
        plot(x(:),y(:),'*')
        axis equal;
        
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
       
%        r1 = [4,3,0.5;5,7,6;6,10,8]
%        r2 = [3,4,1;5,4,5;0.5,2,2]
%        r(:,:,1) = r1;
%        r(:,:,2) = r2;

r(:,:,1,1) = [1 5 8; 9 3 15; 10 1 9]
r(:,:,2,1) = [4 5 8; 3 10 5; 9 8 13]
r(:,:,3,1) = [10 2 3; 8 9 7; 3 6 4]
r(:,:,1,2) = [5 4 6; 9 2 10; 13 12 1]
r(:,:,2,2) = [ 2 8 10; 12 14 8; 6 5 1]
r(:,:,3,2) = [8 9 3; 5 4 10; 12 6 3]
r(:,:,1,3) = [9 7 13; 12 10 6; 5 7 4]
r(:,:,2,3) = [ 8 10 6; 7 4 10; 9 7 2]
r(:,:,3,3) = [1 6 4; 2 5 8; 14 3 8]


       thrLTE_fap = r;
       thrLTE_fap
       
       
       thrLTE_common = get_common_multiBS(thrLTE_fap, nodes,k);
       thrLTE_common
       nodes
       k 
       
       r_fap = rateShannon_multiBS(CIR_fap, B)./ nodes;
       r_common = rateShannon_multiBS_common(r_fap, nodes,k); 

    
       optGr_r = get_entries_greedy_multiBS(r_fap, r_common, k);   
       optRand_r = get_entries_random_multiBS(r_fap, r_common, k);
       optMaxReg_r = get_entries_max_regret_multiBS(r_fap, r_common, k);
       optMaxRegUser_r = get_entries_max_regret_user_multiBS(r_fap,r_common, k);
       
       optGr_LTE = get_entries_greedy_multiBS(thrLTE_fap, thrLTE_common, k)   
       optRand_LTE = get_entries_random_multiBS(thrLTE_fap, thrLTE_common, k)
       optMaxReg_LTE = get_entries_max_regret_multiBS(thrLTE_fap, thrLTE_common, k)
       optMaxRegUser_LTE = get_entries_max_regret_user_multiBS(thrLTE_fap,thrLTE_common, k)
       
       seGrLTE = seGrLTE + sum(optGr_LTE) ./ (faps * B);
       seRand_LTE = seRand_LTE + sum(optRand_LTE) ./ (faps * B);
       seMaxReg_LTE = seMaxReg_LTE + sum(optMaxReg_LTE) ./ (faps * B);
       seMaxRegUser_LTE = seMaxRegUser_LTE + sum(optMaxRegUser_LTE) ./ (faps * B);
       
       s1(i) = sum(optGr_LTE) ./ (faps * B);
       s2(i) = sum(optMaxReg_LTE) ./ (faps * B);
       seGrSh = seGrSh + sum(optGr_r) ./ (faps * B);
       seRand_Sh = seRand_Sh + sum(optRand_r) ./ (faps * B);
       seMaxReg_Sh = seMaxReg_Sh + sum(optMaxReg_r) ./ (faps * B);
       seMaxRegUser_Sh = seMaxRegUser_Sh + sum(optMaxRegUser_r) ./ (faps * B);

        
       histGrThrSh = histGrThrSh + hist(optGr_r, xesThrSh) ./ (faps * nodes);   
       histRThrSh = histRThrSh + hist(optRand_r, xesThrSh) ./ (faps * nodes);
       histMaxRegThrSh = histMaxRegThrSh + hist(optMaxReg_r, xesThrSh) ./ (faps * nodes);
       histMaxRegUserThrSh = histMaxRegUserThrSh + hist(optMaxRegUser_r, xesThrSh) ./ (faps * nodes);
       
       histGrThrLTE = histGrThrLTE + hist(optGr_LTE, xesThrLTE) ./ (faps * nodes);
       histRThrLTE = histRThrLTE + hist(optRand_LTE, xesThrLTE) ./ (faps * nodes);      
       histMaxRegThrLTE = histMaxRegThrLTE + hist(optMaxReg_LTE, xesThrLTE) ./ (faps * nodes);
       histMaxRegUserThrLTE = histMaxRegUserThrLTE +hist(optMaxRegUser_LTE, xesThrLTE) ./ (faps * nodes);
    
    end
    toc
   
       histGrThrSh = histGrThrSh ./ drops;  
       histRThrSh = histRThrSh ./ drops; 
       histMaxRegThrSh = histMaxRegThrSh ./ drops; 
       histMaxRegUserThrSh = histMaxRegUserThrSh ./ drops;
       histGrThrLTE = histGrThrLTE./drops;
       histRThrLTE = histRThrLTE./drops;
       histMaxRegThrLTE = histMaxRegThrLTE./drops;
       histMaxRegUserThrLTE = histMaxRegUserThrLTE./drops;
       seGrLTE_d_d(d) = seGrLTE ./ drops;
       seRand_LTE_d_d(d) = seRand_LTE ./ drops;
       seMaxReg_LTE_d_d(d)= seMaxReg_LTE ./ drops;
       seMaxRegUser_LTE_d_d(d)= seMaxRegUser_LTE ./ drops;   
       seGrSh_d_d(d) = seGrSh ./ drops;
       seRand_Sh_d_d(d) = seRand_Sh ./ drops;
       seMaxReg_Sh_d_d(d)= seMaxReg_Sh ./ drops;
       seMaxRegUser_Sh_d_d(d)= seMaxRegUser_Sh ./ drops; 
       
       seGrLTE_d = seGrLTE ./ drops;
       seRand_LTE_d = seRand_LTE ./ drops;
       seMaxReg_LTE_d= seMaxReg_LTE ./ drops;
       seMaxRegUser_LTE_d= seMaxRegUser_LTE ./ drops;
       
       seGrSh_d = seGrSh ./ drops;
       seRand_Sh_d = seRand_Sh ./ drops;
       seMaxReg_Sh_d= seMaxReg_Sh ./ drops;
       seMaxRegUser_Sh_d= seMaxRegUser_Sh ./ drops; 
  end


% plot(xesThrSh, cumsum(histGrThrSh), xesThrSh, cumsum(histRThrSh),xesThrSh, cumsum(histMaxRegThrSh),xesThrSh, cumsum(histMaxRegUserThrSh))
plot(xesThrLTE, cumsum(histGrThrLTE), xesThrLTE, cumsum(histRThrLTE), xesThrLTE, cumsum(histMaxRegThrLTE),xesThrLTE, cumsum(histMaxRegUserThrLTE))
% plot( xesThrLTE, cumsum(histMaxRegThrLTE),xesThrLTE, cumsum(histMaxRegUserThrLTE))
% plot(xesThrSh, cumsum(histGrThrSh))
% plot(cumsum(seGrLTE_d),cumsum(seRand_LTE_d),cumsum(seMaxReg_LTE_d),cumsum(seMaxRegUser_LTE_d),'*');
% 
% a= [seGrLTE_d, seRand_LTE_d,seMaxReg_LTE_d,seMaxRegUser_LTE_d]
% b= [seGrSh_d, seRand_Sh_d,seMaxReg_Sh_d,seMaxRegUser_Sh_d]
% 


   