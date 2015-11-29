function [accuracy]=intest(x,labelt,w)
predict=x*w;
correct=((predict.*labelt)>0);
accuracy=sum(correct)/length(labelt);
end