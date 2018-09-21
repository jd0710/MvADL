function [P,W]=correlated(Ytr,Xtr,alpha,lada,yiita,lamda,Magni_H)
maxIter =50;
iter = 0;
N_sample=size(Ytr,2);
V_view=length(Xtr);
[C,class_id]=max(Ytr);
for i=1:1:length(Xtr)
    [Z{i}]=extend_H( Ytr,Magni_H );
end
%% main loop
object=[];
term1=[];
term2=[];
F_dictionary=[];
F_W=[];
Accuracy=[];
Parameter=['magni=',num2str(Magni_H),'alpha=',num2str(alpha), 'yita=',num2str(yiita),...
    'lada=',num2str(lada),'lamda=',num2str(lamda)];
while iter<maxIter
    iter = iter + 1;
    disp(['iter number is ' num2str(iter)])
    %% update Pi
    for i=1:1:length(Xtr)
        L{i}=chol(Xtr{i}*Xtr{i}'+lada*yiita*eye(size(Xtr{i}*Xtr{i}')),'lower');
        [U{i},S{i},V{i}]=svd(L{i}\(Xtr{i}*Z{i}'),'econ');
        Pa=S{i}*S{i}'+(4*lada).*eye(size(S{i}*S{i}'));
        Pb=S{i}+sqrt(Pa);
        Pc=V{i}*Pb*U{i}'/L{i};
        P{i}=Pc./2;
    end
    Z_co=[];
    for i=1:1:length(Xtr)
        Z_co=[Z_co;Z{i}];
    end
    
    %% update W
    W=Ytr*Z_co'/(Z_co*Z_co'+lamda.*eye(size(Z_co*Z_co')));
    
    %% updateYtr
    H =W*Z_co;
    H=H';
    for ind = 1:size(Xtr{1},2)
        R(ind,:) = optimize_R(H(ind,:), class_id(ind));
    end
    Ytr=R';
    %% update Z_co
    PX=[];
    for i=1:1:length(Xtr)
        PX=[PX;P{i}*Xtr{i}];
        [d{i+1},m]=size(PX);
    end
    d{1}=0;
    Z_co=(eye(size(W'*W))+alpha.*W'*W)\(alpha.*W'*Ytr+PX);
    for i=1:1:length(Xtr)
        Z{i}=Z_co(d{i}+1:d{i+1},:);
        for k=i:1:size(Z{i},2)
            for j=1:1:size(Z{i},1)
                if j<=Magni_H*(class_id(k)-1)
                    if  abs(Z{i}(j,k))<0.01
                        Z{i}(j,k)=0;
                    end
                else if j>Magni_H*class_id(k)
                        %Z{i}( abs(Z{i}(j,k))<0.01)(j,k)=0;
                        if  abs(Z{i}(j,k))<0.01
                            Z{i}(j,k)=0;
                        end
                    end
                end
            end
        end
        %     Z{i}( abs(Z{i})<0.01)=0;
    end
    ter1=0;
    ter2=0;
    Fdic=0;
    F_W_classifer=0;
    for i=1:1:V_view
        ter1=ter1+norm(Z{i}-P{i}*Xtr{i},'fro');
        Fdic=Fdic+norm(P{i},'fro');
    end
    term1=[term1,ter1];
    ter2=norm(W*PX-Ytr,'fro');
    term2=[term2,ter2];
    F_dictionary=[F_dictionary,Fdic];
    F_W_classifer=norm(W,'fro');
    F_W=[F_W,F_W_classifer];
    obj=ter1+alpha*ter2+lamda*F_W_classifer;
    object=[object,obj];
    [acc]=classification(P,W);
    fprintf('ACC=%0.4f\n',acc*100)
    Accuracy=[Accuracy,acc];
    objective_all=[Accuracy;object;term1;term2;F_dictionary;F_W];
end
%%
load ./result.mat
newresult=cell(2,1);
newresult(1,1)={Parameter};
newresult(2,1)={objective_all};

newcell={newresult};
result=[result newcell];
save result.mat result



