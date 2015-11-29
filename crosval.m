function result=crosval(train,label0,pho,c)


% shuffle
label=zeros(length(label0),1);    %vector
a=zeros(size(train));
m=size(train,1);            
srt=randperm(m); %sort training set randomly
    
for i=1:m    
    a(i,:)=train(srt(i),:); 
    label(i)=label0(srt(i));
end


%initial
np=length(pho);
nc=length(c);
number=np*nc;
po_new=zeros(number,1);     %for return
c_new=zeros(number,1);      %for return
acc=zeros(number,1);

k=1;           
n=round(m/10);             %the size for divide data

for i=1:np
    for j=1:nc
    r0=pho(i);
    c0=c(j);
    po_new(k)=r0;
    c_new(k)=c0;
    acy=zeros(10,1);

    
    %cross validation
    for ii=1:10
        st=(ii-1)*n+1;
        if ii==10
            en=m;
        else
            en=ii*n;
        end
        
        % take test set
        te=[];               %test data
        lb_te=[];           %test label
        te=a(st:en,:);
        lb_te=label(st:en);
        
        % take training set
        if ii==1
            tr=a(en+1:end,:);
            lb=label(en+1:end);
        else if ii==10
                tr=a(1:st-1,:);
                lb=label(1:st-1);
            else
                tr=[a(1:st-1,:);a(en+1:end,:)];
                lb=[label(1:st-1);label(en+1:end)];
            end
        end
        
        
        w=[];
        w=svm(tr,lb,r0,c0,10);
        acy(ii)=intest(te,lb_te,w);
    end
    
    acc(k)=sum(acy)/length(acy);
    k=k+1;
    end
end

result=[po_new,c_new,acc];

end
    