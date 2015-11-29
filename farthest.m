function d=farthest(data)


dim=size(data,2);
d=data(:,1:dim-1);

distance=sum(d.^2,2);
maxd=max(distance);
d=sqrt(maxd);

end



