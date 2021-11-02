clear;clc
fprintf('三点法\n')
tic
%Load=xlsread('G:\桌面\随机数');%%在此修改加载的文件名，数据格式一直才可正确运算%%
Load=randi([-30,30],50,1);Load=Load.';%取样范围-30到30 50个点

%Load=[5,-1,3,-4,4,-2,1,-3,0,-2];
subplot(2,2,1);
x=1:1:length(Load);
plot(x,Load);
title('原始数据');

Load1=Load;
Load2=Load;
L3=length(Load2);
%去除除了峰谷之外的数据
m1=L3;
for i=2:1:m1-1
    if Load2(i-1)<=Load2(i)&&Load2(i)<=Load2(i+1)%斜率大于零
        Load1(i)=NaN;
    else if Load2(i-1)>=Load2(i)&&Load2(i)>=Load2(i+1)%斜率小于零
        Load1(i)=NaN;
        end
    end
end
Load1(isnan(Load1))=[];%删除非峰谷的点


%对载荷时间历程再造，使从最大（小）值拆开，前后拼接，使从最值开始最值结束
[b,c]=max(Load1);
n1=length(Load1);
B1=Load1(c:n1);
B2=Load1(1:c);
Load1=[B1,B2];
%再只留波峰波谷，防止拼接处出现不合理的数据

Load2=Load1;
m1=length(Load1);

for i=2:1:m1-1
    if Load2(i-1)<Load2(i)&&Load2(i)<Load2(i+1)
        Load1(i)=NaN;
    elseif Load2(i-1)>Load2(i)&&Load2(i)>Load2(i+1)
        Load1(i)=NaN;
    end
end
Load1(isnan(Load1))=[];

subplot(2,2,2);
x=1:1:length(Load1);
plot(x,Load1);
title('波峰波谷数据');

a=zeros(2,length(Load1));%把数据以坐标的形式放到二位数组

for i=1:length(Load1)
a(1,i)=i;%表示存储的第几个数据
a(2,i)=Load1(i);%存储的数据值
end

Amplitude=[];%存幅度值
Mean=[];%存均值


%b1={a(1,1);a(2,1)};
b1=[a(1,1),a(1,2);a(2,1),a(2,2)];
a(:,1)=[];%删除原数据第一个点
a(:,1)=[];%删除原数据第二个点

i=3;
n=2;%提取到b1的点数目
k=length(a(1,:));
while length(a(1,:))>=1
    
    if(n<3&&length(a(1,:))>=1)
        b1=[b1 [a(1,1);a(2,1)]];%读入数据
        a(:,1)=[];%删除原数据点
        n=n+1;
        if(n>=3)
         m=length(b1(1,:))-2;
         Y=abs(b1(2,m)-b1(2,m+1));
         X=abs(b1(2,m+2)-b1(2,m+1));
        if(X>=Y)
         Amplitude=[Amplitude abs(b1(2,m)-b1(2,m+1))];%存幅度值
         Mean=[Mean (b1(2,m)+b1(2,m+1))/2];%存均值
        fprintf('循环路径:(%d,%d)->(%d,%d) 变程：%d  均值：%.2f\n',b1(1,m),b1(2,m),b1(1,m+1),b1(2,m+1),abs(b1(2,m)-b1(2,m+1)),(b1(2,m)+b1(2,m+1))/2);
         
         b1(:,m)=[];%删除处理过的数据三个点中第一个点
         b1(:,m)=[];%删除处理过的数据三个点中第二个点
         n=n-2;
        else
            n=n-1;
            continue;
        end
        else
            continue;
        end
     
    else
    continue;
    end
end


%处理提取到b1的剩余数据
while length(b1(1,:))>=3
     m=length(b1(1,:))-2;
         Y=abs(b1(2,m)-b1(2,m+1));
         X=abs(b1(2,m+2)-b1(2,m+1));
        if(X>=Y)
        Amplitude=[Amplitude abs(b1(2,m)-b1(2,m+1))];%存幅度值
        Mean=[Mean (b1(2,m)+b1(2,m+1))/2];%存均值
        fprintf('循环路径2:(%d,%d)->(%d,%d) 变程：%d  均值：%.2f\n',b1(1,m),b1(2,m),b1(1,m+1),b1(2,m+1),abs(b1(2,m)-b1(2,m+1)),(b1(2,m)+b1(2,m+1))/2);
         
         b1(:,m)=[];%删除处理过的数据三个点中第一个点
         b1(:,m)=[];%删除处理过的数据三个点中第二个点
        end
end

subplot(2,2,3);
x=1:1:length(Amplitude);
plot(x,Amplitude);
title('变程');

subplot(2,2,4);
x=1:1:length(Mean);
plot(x,Mean);
title('均值');

toc



