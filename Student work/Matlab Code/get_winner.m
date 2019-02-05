function winner = get_winner(algorithm1,algorithm2,algorithm3,algorithm4)

cum_alg1= sum(algorithm1);
cum_alg2= sum(algorithm2);
cum_alg3= sum(algorithm3);
cum_alg4= sum(algorithm4);

if (cum_alg1 >= cum_alg2)& (cum_alg1 >= cum_alg3)&(cum_alg1 >= cum_alg4)
    
    winner =1;
else 
    winner =0;
    
end
end