clear all; close all;

%==============================================================
%目的：
%%%%%根据DCT基本公式编写程序生成DCT变换矩阵C，对8*8DCT变换矩阵产生
%%%%%基图像。对图像（矩阵）作DCT和IDCT，进行观察
%==============================================================

%------------------------------basic----------------------------%
%x=sampleim;


%------------------------------DCT--------------------------------%
N=8;
n=log2(N);

%------------------------------DCT2-------------------------------%
C1=zeros(N,N); %zeros(m)生成一个m*m大小的全0矩阵数组
C1(1,:)=sqrt(1/N);  %sqrt平方根
for m=2:N
    for i=1:N
        C1(m,i)=sqrt(2/N)*cos((2*i-1)*pi*(m-1)/(2*N));
    end
end

%------------------------------DCT5-------------------------------%
C2=zeros(N,N); %zeros(m)生成一个m*m大小的全0矩阵数组

for k=1:N
    for n=1:N
        w0 = 1;w1=1;
        if k == 1
            w0 = sqrt(0.5);
        end
        if n == 1
            w1 = sqrt(0.5);
        end
        C2(k,n) = cos(pi*(n-1)*(k-1)/(N-0.5))*w0*w1*sqrt(2/(N-0.5));
    end
end
%------------------------------DCT8-------------------------------%
C3=zeros(N,N); %zeros(m)生成一个m*m大小的全0矩阵数组
for k=1:N
    for n=1:N
        C3(k,n) = cos(pi*(k-0.5)*(n-0.5)/(N+0.5))*sqrt(2/(N+0.5));
    end
end
%------------------------------DST1-------------------------------%
C4=zeros(N,N); %zeros(m)生成一个m*m大小的全0矩阵数组
for k=1:N
    for n=1:N
        C4(k,n) = sin(pi*n*k/(N+1))*sqrt(2/(N+1));
    end
end

%------------------------------DST7-------------------------------%
C5=zeros(N,N); %zeros(m)生成一个m*m大小的全0矩阵数组
for k=1:N
    for n=1:N
        C5(k,n) = sin(pi*(k-0.5)*n/(N+0.5))*sqrt(2/(N+0.5));
    end
end

str1 = ['2' '5' '8' '1' '7'];
str2 = ['C' 'C' 'C' 'S' 'S'];

%-----------------------------------base images-------------------------
for i = 1:5
    SCR=get(0,'ScreenSize');
    MAG1=0.8*SCR(3)/640;
    Z1=[188 2 450 450]*MAG1;
    FIG1=figure('Pos',Z1,'Vis','off','Number','off','Men','none');
    y=zeros(N,N);
    s=0.95/N;
    s1=0.95*s;  
    if i == 1
        Org = C1;
    end
    if i == 2
        Org = C2;
    end
    if i == 3
        Org = C3;
    end
    if i == 4
        Org = C4;
    end
    if i == 5
        Org = C5;
    end
    C=Org*sqrt(N);                            %for what...
    imgsave = figure(FIG1);clf;axis off;
    set(FIG1,'Color',[1 1 .6],'Vis','on','Name','稍候, 计算DHT基图象...');
    for m=1:N;
         for n=1:N
          ZZ=[0.025+(m-1)*s 0.985-(n)*s s1 s1];
          AX(m,n)=axes('Pos',ZZ,'Vis','off','Units','normalized');
             for k=1:N
                  y(k,:)=sqrt(N)*C(n,:)*C(m,k);
             end
           img = mat2gray(y);
           imshow(img);
         end
    end
    name = ['D',str2(i),'T',str1(i),'基图像'];
    set(FIG1,'Name',name);
    print(FIG1,'-r600','-djpeg',name);
    close all;
end
