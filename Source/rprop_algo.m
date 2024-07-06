function [fwih,fwho,bh,bo]=rprop_algo(Energy, Avg_Entropy, Mean, Std_dev, t)
x1=[Energy Avg_Entropy Mean Std_dev];

bh=rand(4);
bo=rand(1);
etap=1.2;
etan=0.5;
epoch=1;
epochmax=2000;
wih=rand(4,4,epochmax);
who=rand(4,epochmax);
flag=1;
alpha=1;
k=2;
while epoch<epochmax
    %input to hidden layer
    for l=1:length(Energy)
    for i=1:4
        y1(i)=0;
        for j=1:4
            y1(i)=y1(i)+x1(i)*wih(i,j,k);
        end
        y1(i)=y1(i)+bh(i);
        yo1(i,1)=(1/1+exp(-1*y1(i)));   %activation
    end
    %hidden to output layer
    yin=0;
    for j=1:4
        yin=yin+yo1(j,1)*who(j);
    end
    yin=yin+bo;
    yout(l)=(1/1+exp(-1*yin));  %activation
    
    %calculation from output to hidden
    e(l)=(t(l)-yout(l));    %error calculation    
    delk=e(l)*(1-yout(l))*yout(l);
    end
    if yout==t
        flag=0;
        break;
    else
    %gradient calculation
    for i=1:4
        grad_ho(i,k)=delk*yo1(i,1);
    end
    
    %calculation from hidden to input
    for i=1:4
        delkh(i)=yo1(i,1)*(1-yo1(i,1))*who(i)*delk;
    end
     %gradient calculation
    for i=1:4
        for j=1:4
        grad_ih(i,j,k)=delkh(j)*x1(i);
        end
    end
    
    %resilient back propagation algorithm
    for i=1:4
        for j=1:epochmax
            delta_ih(i,j)=0.001;
            delta_ho(i,j)=0.001;
        end
    end
    
    delta_max=50;
    delta_min=10^(-6);
    
    for i=1:4
        
        deltaw_ho(i,k)=0;
        c=grad_ho(i,k);
        
        if c>0             
             deltaw_ho(i,k)=-delta_ho(i,k);            
        else
             if c==0
                  deltaw_ho(i,k)=0;                    
             else
                  deltaw_ho(i,k)=-delta_ho(i,k);
             end            
        end
       
        c=grad_ho(i,k)*grad_ho(i,k-1);
       
        if c>0
             delta_ho(i,k)=delta_ho(i,(k-1))*etap;             
        else
             if c==0
                  delta_ho(i,k)=delta_ho(i,(k-1));
             else
                  delta_ho(i,k)=delta_ho(i,(k-1))*etan;
             end            
        end
        
        deltaw_ho(i,k)=deltaw_ho(i,k-1)+delta_ho(i,k);  
        bo=bo+delta_ho(i,k);
    end
    for b=1:4           %weight updation
        who(b,k)=who(b,k)+delta_ho(b,k);
    end
    
    
    temp=zeros(4);
    for i=1:4  
        for j=1:4
        deltaw_ih(i,j,k)=0;
        c=grad_ih(i,i,k);        
        if c>0             
             deltaw_ih(i,j,k)=-delta_ih(i,j,k);            
        else
             if c==0
                  deltaw_ih(i,j,k)=0;                    
             else
                  deltaw_ih(i,j,k)=-delta_ih(i,j,k);
             end            
        end
       
        c=grad_ih(i,j,k)*grad_ih(i,j,k-1);       
        if c>0
             delta_ih(i,j,k)=delta_ih(i,j,(k-1))*etap;             
        else
             if c==0
                  delta_ih(i,j,k)=delta_ih(i,j,(k-1));
             else
                  delta_ih(i,j,k)=delta_ih(i,j,(k-1))*etan;
             end            
        end
        end
        deltaw_ih(i,j,k)=deltaw_ih(i,j,k-1)+delta_ih(i,j,k);       
    end
    
    for a=1:4
    bh(a)=bh(a)+delta_ih(a,a,k);
    for b=1:4       %weight updation
        wih(a,b,k)=wih(a,b,k)+delta_ih(a,b,k);
    end
    end
    
    k=k+1;
    epoch=epoch+1;
    end
end
for a=1:4
    for b=1:4
        fwih(a,b)=wih(a,b,k-1)+delta_ih(a,b,k-1);
    end
end

for b=1:4
    fwho(b)=who(b,k-1)+delta_ho(b,k-1);
end

