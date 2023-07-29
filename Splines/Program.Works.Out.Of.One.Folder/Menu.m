function Menu()
set(0,'DefaultAxesFontSize',8,'DefaultAxesFontName','Times New Roman');
button = menu('�������� �����', '������������������ ������ ���������','������������ ����������','�� ������', '�����');
switch button
    case 1 %%% ������ ������
        try 
        %x (x_ � 69 ������) - ������ ������� �������� {X}
        %y (�_ � 69 ������) - ������ ������� �������� {Y}
        %N - ���. ����� ������������
        %����� ����� � �������� �
        options.Interpreter = 'tex';
        options.Default = '� �����'; 
        qstring = '����� ������� ��������� ���� ������� ����� (�)?';
        choice = questdlg(qstring,'���� ������ ��������','� �����','������ �������',options);
       switch choice
        case '� �����'
               FileName = uigetfile('*.txt','�������� ���� � �������� ������� � ');
               x=dlmread(FileName);
        case '������ �������'
                  %%
                    inp = inputdlg({'������� �������� ����� ������ " " ��� �������","'},'������� ������',[1 40],{'3.2 4.1 9.2 7.5 2.5'});
                    x = str2num(inp{1});
                     if(isempty(inp))
                         mode = struct('WindowStyle','modal',... 
                         'Interpreter','tex');
                          h = errordlg('��������� ����� ������������!!! ������ ����� �������',...
                            'Error', mode); 
                          waitfor(h);
                          close;
                     end
           otherwise
               close;
       end
         myicon = imread('warning.jpg');
         h=msgbox('.* --- �������� ��������� ./ --- �������� ������� .^ --- �������� ���������� � �������','���. �������� ������','custom',myicon);
         waitfor(h);
         ans = inputdlg({'��������������� f(x):'},'������� ������',[1 40],{'sin(x)'});
        if(isempty(ans))
            mode = struct('WindowStyle','modal',... 
            'Interpreter','tex');
            h = errordlg('��������� ����� ������������!!! ������ ����� �������',...
            'Error', mode); 
            waitfor(h);
            close;
        end
        inp=cell2str(ans);
        func=inp(3:length(inp)-3);
        g=inline(func);
        bool=isempty(func);
        if(bool)
            close();
        end;
        y=(g(x));
    %���������� ���������� ����� �� �����������
    [x,I] = sort(x); % � ������� I �������� ������ �������    
    %��� ������������ ������� � 
        y = y(I); % ����������� ���� �� ������ �������
        answer = inputdlg({'��������������� �� A_x:','�� B_x:','���������� ����� ������������'},'������� ������',[1 40;1 40;1 40],{'2.5','9.2','2000'});
        inp_data(1)=str2double(answer(1));
        inp_data(2)=str2double(answer(2));
        inp_data(3)=str2double(answer(3));
        if(inp_data(1)>inp_data(2))
            A=inp_data(2);
            B=inp_data(1);
        else
            A=inp_data(1);
            B=inp_data(2);
        end
        N=inp_data(3);
        if(N<0 || N==0)
            mode = struct('WindowStyle','modal',... 
            'Interpreter','tex');
            h = errordlg('������������� ���������! �� ����� ����������� ���. �����!',...
            'Error', mode); 
            waitfor(h);
            close;
        end;
   if(A<min(x)||B>max(x))
            mode = struct('WindowStyle','modal',... 
            'Interpreter','tex');
            h = errordlg('���������� ����� ��� ���������������� ����������� �� ������� �������� ���������! ������ �������� ������������ ��� ����������� ������.',...
            'Error', mode); 
            waitfor(h);
            options.Interpreter = 'tex';
            options.Default = '��'; 
            qstring = '������������� ��������� ��� ������������ ����������� ����������?';
            choice = questdlg(qstring,' ���� ������ �������� ',...
            '��','���������� ������',options);
    switch choice
        case '��'
            close;
            Menu();
        case '���������� ������'
                        mode = struct('WindowStyle','modal',... 
            'Interpreter','tex');
            h = warndlg('������������ ���������� ����������� ��� ������� ������� ����� �� �������������!!!','��������������',mode);
            waitfor(h);
        otherwise
            close;
    end   
   end;
        x_=x;
        y_=y;
        GenPoint(A,B,N,'X.txt');
        tic;
        x=linspace(A,B,N);
        y=(g(x));
   time=toc;
        %% ����� ���������������� �������
        figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
        axes;
        whitebg('b');
         %% �������� ���� � ������ ������� ��������� 
            h = waitbar(0, '���� ������ �������� ...'); 
            % ����� ��������� �� ������������� ������ 
            hP = findobj(h, 'Type', 'patch'); 
            % ������� ����� ������������ � ������� �������������� ������� 
            set(hP, 'FaceColor', 'w', 'EdgeColor', 'g') 
            for i=1:1000
                waitbar(i/1000, h) 
            end 
            close(h);
        %% ����� ��������������� �������
        Ak=Akima(x_,y_,x,y,func);
        Cu=Cubic(x_,y_,x,y,func);
        He=Hermit(x_,y_,x,y,func);
        %% ���������� ������� �������
        hold on
        subplot(2, 2, 1);
        plot_1=plot(x_,y_,'--go',x,y,'r');
        title('������ �1');
        xlabel('X');
        ylabel('Y');
        leg=legend('���. ������.','������ ��������','Location','southeast');
        set(plot_1,'LineWidth', 5); 
        grid on;
        %% ����� ���������� �� �������� 
        eps=3;
        %%
        result{1}='             ������ ��������';
        result{2}=['����� ���������� ==> ' mat2str(time,eps)];
        result{3}=['���. ����� ������������ ==> ' num2str(N)];
        result{4}=['������ ��. ����. ==> ' num2str(0)];
        %%
        result{6}='             ������ �����';
        result{7}=['����� ���������� ==> ' mat2str(Ak(1),eps)];
        result{8}=['���. ����� ������������ ==> ' num2str(N)];
        result{9}=['������ ��. ����. ==> ' num2str(Ak(2),eps)];
        %%
        result{11}='        ������ ����. ����������';
        result{12}=['����� ���������� ==> ' mat2str(Cu(1),eps)];
        result{13}=['���. ����� ������������ ==> ' num2str(N)];
        result{14}=['������ ��. ����. ==> ' num2str(Cu(2),eps)];
        %%
        result{16}='            ������ ������';
        result{17}=['����� ���������� ==> ' mat2str(He(1),eps)];
        result{18}=['���. ����� ������������ ==> ' num2str(N)];
        result{19}=['������ ��. ����. ==> ' num2str(He(2),eps)];
        T=msgbox(result,'���������');
        waitfor(T);
        
        %% ������ ������ � ��������� ���� � ����
        otc{1,1}='�������� ������';
        otc{1,2}='����� ����������';
        otc{1,3}='���. �����';
        otc{1,4}='����. ��. ����. ';
        %%
        otc{2,1}='���. �����';
        otc{2,2}=mat2str(Ak(1),eps);
        otc{2,3}=num2str(N);
        otc{2,4}=num2str(Ak(2),eps);
        %%
        otc{3,1}='���. ���.';
        otc{3,2}=mat2str(Cu(1),eps);
        otc{3,3}=num2str(N);
        otc{3,4}=num2str(Cu(2),eps);
        %%
        otc{4,1}='���. ������';
        otc{4,2}=mat2str(He(1),eps);
        otc{4,3}=num2str(N);
        otc{4,4}=num2str(He(2),eps);
        %%
        otc{5,1}='������ ����.';
        otc{5,2}=mat2str(time,eps-4);
        otc{5,3}=num2str(N);
        otc{5,4}=num2str(0);
        xlswrite('Result',otc);
        %% ������ ����������
        options.Interpreter = 'tex';
        options.Default = '���';
        qstring = '����������� ������?';
    choice = questdlg(qstring,'���� ������ �������� ',...
        '��','���',options);
    switch choice
    case '��'
        printdlg();
        close;
        Menu();
    case '���'
        close;
        Menu();
    otherwise
        close;
        Menu();
    end
      catch
            mode = struct('WindowStyle','modal',... 
            'Interpreter','tex');
            h = errordlg('������ �� ����� ����������!!!������ ����������� ��� ���������� ����� � ������ �����.',...
            'Error', mode); 
            waitfor(h);
            close;
            Menu();
       end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    case 2 
        %% CPU    
        if isunix
          myicon = imread('error.jpg');
          h=msgbox('���� �� �� �������� ��� ����������!!!','����������','custom',myicon);
          close;
          Menu();
        else
         info = CPUinfo();
         info.Name=['CPU -- ' info.Name];
         info.Clock=['������� -- ' info.Clock];
         info.Cache=['��� 3-�� -- ' info.Cache];
         info.OSType=['�� -- ' info.OSType];
         core=['���� -- ' mat2str(info.NumProcessors) 'x'];
         result{1}=mat2str(info.Name);
         result{2}=mat2str(info.Clock);
         result{3}=mat2str(info.Cache);
         result{4}=core;
         result{5}=mat2str(info.OSType);
         T=msgbox(result,'���������');
         waitfor(T);
         close();
         Menu();
        end;     
        %% �� ������
    case 3
          myicon = imread('photo.jpg');
          h=msgbox('�����: ������� ������ 335��.�������� ������. ����: "����������� �-��� ��������� 3-�� �������. 2016�"','�������������� ����','custom',myicon);
          waitfor(h);
          close;
          Menu();
          %% �����
    case 4 
        exit();
    otherwise
        close;
  end