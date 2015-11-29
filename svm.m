function w=svm(a,label0,pho0,c,T)


t=0;
w=zeros(size(a,2),1);
m=size(a,1); %the number of examples


for j=1:T  
    label=zeros(1,length(label0));
    train=zeros(size(a));
    srt=randperm(m); %sort training set randomly
    
    for i=1:m    %shuffle
       train(i,:)=a(srt(i),:); 
       label(i)=label0(srt(i));
    end
    
    for i=1:m
        r_t=pho0/(1+pho0*t/c);
        sign=train(i,:)*w;
        if label(i)*sign<=1
            w=(1-r_t)*w+r_t*c*label(i)*train(i,:)';
        else
            w=(1-r_t)*w;
        end
        t=t+1;
    end
    
  
    
end