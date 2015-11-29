function b=transform(a)

b=[];
k=1;
add_col=zeros(size(a,1),1);
dim=size(a,2);
    for i=[1:dim]
        for j=[i:dim]
            b=[b add_col];
            b(:,k)=a(:,i).*a(:,j);
            k=k+1;
        end
    end
end
            
        
        