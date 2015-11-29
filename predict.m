function [acc margin]=predict(result,x,y,x_te,y_te)
% using best hyperparameter to pridect data


 position=find(result(:,3)==max(result(:,3)));
 if length(position)>1
     position=position(1);
 end
 r=result(position,1);
 c=result(position,2);
 
 w=svm(x,y,r,c,30);
 margin=1/sqrt((w'*w));
 acc=intest(x_te,y_te,w);
end
 
 