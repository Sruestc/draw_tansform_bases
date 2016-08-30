function dct2d21(action)
%--------------------
%   DCT demo, see E.L.Hall: p.148
%
%   Copyright(c): S.Wang, March 1998
%--------------------
% if nargin<1, action='start'; end

global  FIG FGFLAG ...
        FIG1 ...
        x X x1 C BFLAG BASBUTTON2

%=================================
% if strcmp(action,'start'),

    if figflag('基图象，按Close Bases键关闭此窗口。'), close(FIG1); end
    BFLAG=0;
    bgc=[0 0.3 0];
    
    SCR=get(0,'ScreenSize');
    MAG=0.8*SCR(3)/520;
    MAG1=0.8*SCR(3)/640;
    Z=[1 1 500 375]*MAG;
    Z1=[188 2 450 450]*MAG1;

    FIG1=figure('Pos',Z1,'Vis','off','Number','off','Men','none');
    FIG=figure('MenuBar','none','Pos',Z,'Color',bgc,'Num','off', ...
                'Name','二维DCT');
    FGFLAG=1;

    uicontrol(gcf,'Style','push','String','The image (x)','FontSize',11,'FontWeight','b',...
        'Position',[1 350 100 25]*MAG,'CallBack','Demo_DCT(''dctx'');');

    uicontrol(gcf,'Style','push','String','DCT (C)','FontSize',11,'FontWeight','b',...
        'Position',[1 325 100 25]*MAG,'CallBack','Demo_DCT(''dctC'');');

    uicontrol(gcf,'Style','push','String','X=C''*x*C','FontSize',11,'FontWeight','b',...
        'Position',[1 300 100 25]*MAG,'CallBack','Demo_DCT(''dctX'');');

    uicontrol(gcf,'Style','push','String','x1=C*X*C''','FontSize',11,'FontWeight','b',...
        'Position',[1 275 100 25]*MAG,'CallBack','Demo_DCT(''dctx1'');');

    BASBUTTON2=uicontrol(gcf,'Style','push','String','Show DCT Bases','FontSize',11,'FontWeight','b',...
        'Position',[1 250 100 25]*MAG,'CallBack','Demo_DCT(''2Dbasis'');');

    uicontrol(gcf,'Style','push','String','Info','FontSize',11,'FontWeight','b',...
        'Position',[1 225 100 25]*MAG,'CallBack','Demo_DCT(''info'');');

    uicontrol(gcf,'Style','push','String','Close','FontSize',11,'FontWeight','b',...
        'Position',[1 200 100 25]*MAG,'CallBack','Demo_DCT(''done'');');

  Demo_DCT('godct')
% 
% %========================================
elseif strcmp(action,'godct'),
    x=sampleim;
    C=mydct2(3);        % Figure 3.36(a)
    X=C'*x*C;           % Figure 3.36(b)
    x1=C*X*C';
    Demo_DCT('dctx');

%========================================
elseif strcmp(action,'dctx'),
    figure(FIG);cla;
    img1(mirror(x',0),0,8);
    title('(a) Original image x.','Color','w','FontSize',14,'FontWeight','bold');
    for m=1:8;for n=1:8
        text(n,m,num2str(x(9-m,n)),'Color','r','FontSize',14,'FontWeight','b');
    end;end

%========================================
elseif strcmp(action,'dctC'),
    figure(FIG);cla;
    img1(mirror(real(C*10)',0),0,64);
    title('(b) DCT kernel C, as in Fig.3.36(a)','Color','w','FontSize',14,'FontWeight','bold');
    for m=1:8;for n=1:8
        text(n,m,num2str(real( round(C(9-m,n)*100)/100 )),'Color','r','FontSize',14,'FontWeight','b');
    end;end

%========================================
elseif strcmp(action,'dctX'),
    figure(FIG);cla;
    img1(mirror(real(X)'',0),0,64);
    title('(c) X=DCT(x), as in Fig.3.36(b)','Color','w','FontSize',14,'FontWeight','bold');
    for m=1:8;for n=1:8;
        text(n,m,num2str( round(real(X(9-m,n))*100)/100 ),'Color','r','FontSize',14,'FontWeight','b');
    end;end

%========================================
elseif strcmp(action,'dctx1'),
    figure(FIG);cla;
    img1(mirror(real(x1)',0),0,64);
    title('(d) Inverse DCT (x1).','FontSize',14,'FontWeight','bold','Col','w');
    for m=1:8;for n=1:8
        text(n,m,num2str(real(x1(9-m,n))),'Color','r','FontSize',14,'FontWeight','b');
    end;end

%=============================================
elseif strcmp(action,'2Dbasis'),

  if ~BFLAG,
    K=3;KK=2^K;
    C=mydct2(K);
    C1=C*sqrt(KK);

    y=zeros(KK,KK);
    s=0.95/KK;
    s1=0.95*s;
    figure(FIG1);clf;axis off;
    set(FIG1,'Color',[1 1 .6],'Vis','on','Name','稍候, 计算DCT基图象...');
    for m=1:KK;for n=1:KK
        ZZ=[0.025+(m-1)*s 0.985-(n)*s s1 s1];
        AX(m,n)=axes('Pos',ZZ,'Vis','off','Units','normalized');
        for k=1:KK
            y(k,:)=C1(n,:)*C1(m,k);
        end
        img1(y+1);
    end;end
    set(FIG1,'Name','基图象，按Close Bases键关闭此窗口。');
    BFLAG=1;
    set(BASBUTTON2,'Str','Close Bases');

  else
    BFLAG=0;
    set(BASBUTTON2,'Str','Show DCT Bases');
    figure(FIG1);clf;set(FIG1,'Vis','off');
  end

%=============================================
elseif strcmp(action,'info'),
   ttlStr = '二维离散余弦变换'; 
   str0='  ';
   
   str1='  1。观察空域中的图象及其二维DCT。';
   str2='  2。观察DCT 变换矩阵。';
   str3='  3。IDCT：注意有很小的数值计算误差。';
   str4='  4。观察DCT 基图象及其与DFT的不同。';
   str5='  5。观察一维DCT基函数。';
   str6='  6。观察二维DCT基图象：实部、虚部、辐角。任一基图象为两个一维基函数之外积。';
   hlpStr1=str2mat(str0,str1,str0,str2,str0,str3,str0,str4,str0,str5,str0,str6);
   
   str7=' 思考题：';
   str8=' 1。本实验说明了DCT的哪些性质？ ';
   str9=' 2。试说明二维DCT基的意义。';
   hlpStr2=str2mat(str0,str7,str0,str8,str0,str9);
   
   hlpStr={'说明' hlpStr1;'思考题' hlpStr2};
   helpwin(hlpStr,'说明',ttlStr);

%=============================================
elseif strcmp(action,'done'),
    figure(FIG1);delete(gcf);
    figure(FIG);delete(gcf);
    FGFLAG=0;
end

%================================================
function y=sampleim()
%----------------------
%   y=sampleim() generates the sample image used in E.L.Hall's book.
%----------------------
y= [4 4 4 4 4 4 4 0 ;...
    4 5 5 5 5 5 4 0 ;...
    4 5 6 6 6 5 4 0 ;...
    4 5 6 7 6 5 4 0 ;...
    4 5 6 6 6 5 4 0 ;...
    4 5 5 5 5 5 4 0 ;...
    4 4 4 4 4 4 4 0 ;...
    4 4 4 4 4 4 4 0];

