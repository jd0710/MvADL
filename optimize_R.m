function T = optimize_R(R, label)%�����R������H(ind,:)
    classNum = length(R);
    T = zeros(classNum,1);
    V = R + 1 - repmat(R(label),1,classNum);    %fi   ����
    step = 0;%����yita��
    num = 0;%ѭ������
    for i = 1:classNum
        if i~=label  %fi_j   
            dg = V(i); %V(i)��Ԫ��fi_j������dg��ʾ���ǵ�����һ�
            for j = 1:classNum;  
                if j~=label  %����һ������λ�õ�Ԫ�أ�
                    if V(i) < V(j) %j�ȵ�ǰ��i�󣬱Ƚϣ���������˼�Ļ�Ӧ�ú�yita�Ƚϡ�
                        dg = dg + V(i) - V(j); %��ǰdg��С��һ��i���õ�һ��dg��
                    end%���ܵ����ļ��㷽�����������ɡ�
                end
            end
            if dg > 0
                step = step + V(i); %step���ϵ�ǰֵ
                num = num + 1; %���˵�������һ��i��������
            end
        end
    end
    step = step / (1+num); 
    %yita�����ĳͷ���ѭ��������ӣ�����stepֵ�Ĵ�СӦ���޷��Ƚϡ�
    %�����͵õ���yita��һ�������Ϳ����ã�29���ˡ�
    for i = 1:classNum
        if i == label
            T(i) = R(i) + step;
        else
            T(i) = R(i) + min(step - V(i), 0);
        end
    end
end