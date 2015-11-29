function [a,label]=loaddate(filname,feture)

a=zeros(1,feture+1);
fid=fopen(filname,'r');
k=1 ;
while ~feof(fid)
        tline=fgetl(fid);
        label(k)=eval(tline(1:2));
        space=find((tline==' '));
        colon=find((tline==':'));
        nu=length(space);
        for i=1:nu
            fe=eval(tline(space(i):colon(i)-1))+1;
            if i~=nu
            a(k,fe)=eval(tline(colon(i)+1:space(i+1)));
            end
        end
        a(k,fe)=eval(tline(colon(nu)+1:length(tline)));
    k=k+1;
end

label=label';
fclose(fid);
end