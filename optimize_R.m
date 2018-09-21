function T = optimize_R(R, label)%这里的R所以是H(ind,:)
    classNum = length(R);
    T = zeros(classNum,1);
    V = R + 1 - repmat(R(label),1,classNum);    %fi   向量
    step = 0;%参数yita？
    num = 0;%循环次数
    for i = 1:classNum
        if i~=label  %fi_j   
            dg = V(i); %V(i)是元素fi_j，但是dg表示的是导数那一项。
            for j = 1:classNum;  
                if j~=label  %再找一个其它位置的元素？
                    if V(i) < V(j) %j比当前的i大，比较？按文章意思的话应该和yita比较。
                        dg = dg + V(i) - V(j); %当前dg变小，一个i最后得到一个dg。
                    end%可能导数的计算方法就是这样吧。
                end
            end
            if dg > 0
                step = step + V(i); %step加上当前值
                num = num + 1; %加了迭代数，一个i操作完了
            end
        end
    end
    step = step / (1+num); 
    %yita参数的惩罚随循环逐次增加，但是step值的大小应该无法比较。
    %这样就得到了yita那一参数。就可以用（29）了。
    for i = 1:classNum
        if i == label
            T(i) = R(i) + step;
        else
            T(i) = R(i) + min(step - V(i), 0);
        end
    end
end