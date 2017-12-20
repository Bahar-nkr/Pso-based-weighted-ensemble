function [fitness]=Fitness_func(PredClass_SVM,PredClass_KNN,PredClass_NB,N,dim,testdata,testLabels,population)

for i=1:N
    for j=1:size(testLabels,1)
        
        if PredClass_SVM(j)==PredClass_KNN(j)
            if population(i,1)+population(i,2)>population(i,3)
                particle_lable(j,1)=PredClass_KNN(j);
            else 
                particle_lable(j,1)=PredClass_NB(j);
            end
        elseif PredClass_SVM(j)==PredClass_NB(j)
            if population(i,2)+population(i,3)>population(i,1)
                particle_lable(j,1)=PredClass_SVM(j);
            else 
                particle_lable(j,1)=PredClass_KNN(j);
            end
        elseif PredClass_KNN(j)==PredClass_NB(j)
            if population(i,1)+population(i,3)>population(i,2)
                particle_lable(j,1)=PredClass_KNN(j);
            else 
                particle_lable(j,1)=PredClass_SVM(j);
            end
%         else
%             particle_lable(j,1)=PredClass_CF_DT(j);
        end
    end
    fitness(i)=sum(particle_lable == testLabels)/size(testLabels,1 );
end