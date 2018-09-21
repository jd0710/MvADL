clc
clear all
close all
%% load n-view data
% load ./nus4in5/NUS4in5training1.mat
load ./uspstraining.mat
for i=1:1:length(TrData)
    X{i}=TrData{i};
end
Ytr=H_train;
N=size(X{1},2);
%% preprocess type2
for i=1:1:length(X)
    Xtr{i}=scalecols(X{i});
    % XMean{i} = mean(Xtr{i}')';%ת�ò�����ת�û�����X��������������mean�Ƕ�������ȡ��ֵ�������Ƕ�ȫ������ȡ��ֵ��
    % Xtr{i} = Xtr{i} - repmat(XMean{i}, 1, N);%ȥ��ֵ֮��
end
result=[];
save result.mat result
%% parameter
alpha_para=[1];
lada_para=[1];
yiita_para=[1];
lamda_para=[1];
Magni_H_para=[1];

for Magni_H_select=1:1:length(Magni_H_para)
    Magni_H=Magni_H_para(Magni_H_select);
    for a=1:1:length(alpha_para)
        alpha=alpha_para(a);
        for b=1:1:length(lada_para)
            lada=lada_para(b);
            for c=1:1:length(yiita_para)
                yiita=yiita_para(c);
                for d=1:1:length(lamda_para)
                    lamda=lamda_para(d);
                    disp(['magni=',num2str(Magni_H),'��' ,'alpha=',num2str(alpha),'��' ,'yita=',num2str(yiita),'��' ,...
                        'lada=',num2str(lada),'��','lamda=',num2str(lamda)])
                    %% call train function
                    [P,W]=correlated(Ytr,Xtr,alpha,lada,yiita,lamda,Magni_H);
                end
            end
        end
    end
end
%% call classification function
% [acc]=classification(P,W);
% for i=1:1:length(TtData)
% Xtt{i}=TtData{i}';
% end
% Yte=H_test;
% N=size(Xtt{1},2);
% %% preprocess type2
% for i=1:1:length(Xtt)
% Xte{i}=scalecols(Xtt{i});
% % XMean{i} = mean(Xte{i}')';%ת�ò�����ת�û�����X��������������mean�Ƕ�������ȡ��ֵ�������Ƕ�ȫ������ȡ��ֵ��
% % Xte{i} = Xte{i} - repmat(XMean{i}, 1, N);%ȥ��ֵ֮��
% end
%% classification
% for i=1:1:length(Xte)
% Zte{i}=P{i}*Xte{i};
% end
% Zte_co=[];
% for i=1:1:length(Xte)
% Zte_co=[Zte_co;Zte{i}];
% end
% Y_pre=W*Zte_co;
% [C,Index] = max(Y_pre,[],1);
% [CC,Yte] = max(H_test,[],1);
% acc = length(find(Index==Yte))/length(Yte);
% fprintf('ACC=%0.4f\n',acc*100);