clear;clc
fprintf('���㷨\n')
tic
%Load=xlsread('G:\����\�����');%%�ڴ��޸ļ��ص��ļ��������ݸ�ʽһֱ�ſ���ȷ����%%
Load=randi([-30,30],50,1);Load=Load.';%ȡ����Χ-30��30 50����

%Load=[5,-1,3,-4,4,-2,1,-3,0,-2];
subplot(2,2,1);
x=1:1:length(Load);
plot(x,Load);
title('ԭʼ����');

Load1=Load;
Load2=Load;
L3=length(Load2);
%ȥ�����˷��֮�������
m1=L3;
for i=2:1:m1-1
    if Load2(i-1)<=Load2(i)&&Load2(i)<=Load2(i+1)%б�ʴ�����
        Load1(i)=NaN;
    else if Load2(i-1)>=Load2(i)&&Load2(i)>=Load2(i+1)%б��С����
        Load1(i)=NaN;
        end
    end
end
Load1(isnan(Load1))=[];%ɾ���Ƿ�ȵĵ�


%���غ�ʱ���������죬ʹ�����С��ֵ�𿪣�ǰ��ƴ�ӣ�ʹ����ֵ��ʼ��ֵ����
[b,c]=max(Load1);
n1=length(Load1);
B1=Load1(c:n1);
B2=Load1(1:c);
Load1=[B1,B2];
%��ֻ�����岨�ȣ���ֹƴ�Ӵ����ֲ����������

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
title('���岨������');

a=zeros(2,length(Load1));%���������������ʽ�ŵ���λ����

for i=1:length(Load1)
a(1,i)=i;%��ʾ�洢�ĵڼ�������
a(2,i)=Load1(i);%�洢������ֵ
end

Amplitude=[];%�����ֵ
Mean=[];%���ֵ


%b1={a(1,1);a(2,1)};
b1=[a(1,1),a(1,2);a(2,1),a(2,2)];
a(:,1)=[];%ɾ��ԭ���ݵ�һ����
a(:,1)=[];%ɾ��ԭ���ݵڶ�����

i=3;
n=2;%��ȡ��b1�ĵ���Ŀ
k=length(a(1,:));
while length(a(1,:))>=1
    
    if(n<3&&length(a(1,:))>=1)
        b1=[b1 [a(1,1);a(2,1)]];%��������
        a(:,1)=[];%ɾ��ԭ���ݵ�
        n=n+1;
        if(n>=3)
         m=length(b1(1,:))-2;
         Y=abs(b1(2,m)-b1(2,m+1));
         X=abs(b1(2,m+2)-b1(2,m+1));
        if(X>=Y)
         Amplitude=[Amplitude abs(b1(2,m)-b1(2,m+1))];%�����ֵ
         Mean=[Mean (b1(2,m)+b1(2,m+1))/2];%���ֵ
        fprintf('ѭ��·��:(%d,%d)->(%d,%d) ��̣�%d  ��ֵ��%.2f\n',b1(1,m),b1(2,m),b1(1,m+1),b1(2,m+1),abs(b1(2,m)-b1(2,m+1)),(b1(2,m)+b1(2,m+1))/2);
         
         b1(:,m)=[];%ɾ��������������������е�һ����
         b1(:,m)=[];%ɾ��������������������еڶ�����
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


%������ȡ��b1��ʣ������
while length(b1(1,:))>=3
     m=length(b1(1,:))-2;
         Y=abs(b1(2,m)-b1(2,m+1));
         X=abs(b1(2,m+2)-b1(2,m+1));
        if(X>=Y)
        Amplitude=[Amplitude abs(b1(2,m)-b1(2,m+1))];%�����ֵ
        Mean=[Mean (b1(2,m)+b1(2,m+1))/2];%���ֵ
        fprintf('ѭ��·��2:(%d,%d)->(%d,%d) ��̣�%d  ��ֵ��%.2f\n',b1(1,m),b1(2,m),b1(1,m+1),b1(2,m+1),abs(b1(2,m)-b1(2,m+1)),(b1(2,m)+b1(2,m+1))/2);
         
         b1(:,m)=[];%ɾ��������������������е�һ����
         b1(:,m)=[];%ɾ��������������������еڶ�����
        end
end

subplot(2,2,3);
x=1:1:length(Amplitude);
plot(x,Amplitude);
title('���');

subplot(2,2,4);
x=1:1:length(Mean);
plot(x,Mean);
title('��ֵ');

toc



