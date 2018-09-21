function [acc]=classification(P,W)
%% load n-view data
%load  ./nus4in5/NUS4in5training4.mat
load ./uspstraining.mat
for i=1:1:length(TtData)
    Xtt{i}=TtData{i};
end
Yte=H_test;
N=size(Xtt{1},2);
%% preprocess type2
for i=1:1:length(Xtt)
    Xte{i}=scalecols(Xtt{i});
    % XMean{i} = mean(Xte{i}')';%ת�ò�����ת�û�����X��������������mean�Ƕ�������ȡ��ֵ�������Ƕ�ȫ������ȡ��ֵ��
    % Xte{i} = Xte{i} - repmat(XMean{i}, 1, N);%ȥ��ֵ֮��
end
%% classification
for i=1:1:length(Xte)
    Zte{i}=P{i}*Xte{i};
end
Zte_co=[];
for i=1:1:length(Xte)
    Zte_co=[Zte_co;Zte{i}];
end
Y_pre=W*Zte_co;
[C,Index] = max(Y_pre,[],1);
[CC,Yte] = max(H_test,[],1);
acc = length(find(Index==Yte))/length(Yte);
