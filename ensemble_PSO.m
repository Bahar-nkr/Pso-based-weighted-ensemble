function [gbest,gbestFit]=ensemble_PSO(PredClass_SVM,PredClass_KNN,PredClass_NB,traindata,trainLabels)

N=25;
dim=3;
population=rand(N,dim);

[fitness]=Fitness_func(PredClass_SVM,PredClass_KNN,PredClass_NB,N,dim,traindata,trainLabels,population);

pbest=population;
[gbestFit,indx]=max(fitness);

pbestFit = fitness;
gbest = population(indx , :);


t=0;
iteration=50;
vmax = 6;
vmin = -6;
velocity = -6+ rand(size(population))*12;
w=0.7298;
c1=1.5;
c2=1.5;

while t<iteration
    t=t+1;
    
    for a=1:N
        r1=rand;
        r2=rand;
        for b=1:dim
            update_velocity(a,b)=w*velocity(a,b)+c1*r1*(pbest(a,b)-population(a,b))-c2*r2*(gbest(1,b)-population(a,b));
        end
    end
    
            
velocity = update_velocity;
for s=1:N
    for u=1:dim
        update_population(s,u)=population(s,u)+velocity(s,u);
        if  update_population(s,u)>=1 ||  update_population(s,u)<=0
             update_population(s,u)=population(s,u);
        end
            
    end
end



population=update_population;

[fitness]=Fitness_func(PredClass_SVM,PredClass_KNN,PredClass_NB,N,dim,traindata,trainLabels,population);

for m=1:N
    if pbestFit(1,m) < fitness(1,m)
        
        pbestFit(1,m)=fitness(1,m);
        pbest(m,:)=population(m,:);
        
    end
end

[update_gbestFit,update_indx]=max(fitness);

if gbestFit < update_gbestFit
    gbestFit = update_gbestFit;
    
    indx = update_indx;
    gbest = population(indx , :);
end

end
