clc;

%Load the training data
load('traindatafinal.mat');

%Create the target vector
for q=1:length(traindatafinal)
    if q<42
        t(q)=1;
    else
        if q<112
            t(q)=0;
        else
            if q<430
                t(q)=1;
            else
                if q<687
                    t(q)=0;
                else
                    if q<1240
                        t(q)=1;
                    else
                        if q<1356
                            t(q)=0;
                        else
                            t(q)=1;
                        end
                    end
                end
            end
        end
    end
end
        
%Pass the data to the training algorithm
[wih,who,bh,bo]=rprop_algo(traindatafinal(:,1),traindatafinal(:,2),
traindatafinal(:,3),traindatafinal(:,4),t);

%Save the values of weight and bias vectors of the trained neural network
save('wih.mat');
save('who.mat');
save('bh.mat');
save('bo.mat');
