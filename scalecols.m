function matout=scalecols(matin)
%�Ҿ���aÿ�е����ֵ
[maxpercolumn,]=max(matin,[],1);
matout = matin./repmat(maxpercolumn,size(matin,1),1);
% [max_a,index]=max(a)��
%  ����[max_a,index]=max(a,[],1);
%  ����max_a��������ֵ��index��������ֵ������λ�á�
%  ���磺
%  a =
%      1     2     3
%      2     4     5
%      6     1     3
% % >> [max_a,index]=max(a)
% % max_a =
% %      6     4     5