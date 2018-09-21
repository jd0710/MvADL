function [H]=getH(label)
H=[];
j=1;
for i=1:1:max(label)+1
   for  j=1:1:size(label)
    if i==label(j)+1
        H(1:max(label)+1,j)=0;
        H(i,j)=1;
    end
   end
end