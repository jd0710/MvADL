function matout=scalecols(matin)
%找矩阵a每列的最大值
[maxpercolumn,]=max(matin,[],1);
matout = matin./repmat(maxpercolumn,size(matin,1),1);
% [max_a,index]=max(a)；
%  或者[max_a,index]=max(a,[],1);
%  其中max_a是最大的数值，index是最大的数值所处的位置。
%  例如：
%  a =
%      1     2     3
%      2     4     5
%      6     1     3
% % >> [max_a,index]=max(a)
% % max_a =
% %      6     4     5