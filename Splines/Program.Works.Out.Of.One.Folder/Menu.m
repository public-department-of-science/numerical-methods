function Menu()
set(0,'DefaultAxesFontSize',8,'DefaultAxesFontName','Times New Roman');
button = menu('Выбирете пункт', 'Продемонстрировать работу программы','Конфигурация компьютера','Об авторе', 'Выход');
switch button
    case 1 %%% Начать работу
        try 
        %x (x_ с 69 строки) - вектор узловых значений {X}
        %y (у_ с 69 строки) - вектор узловых значений {Y}
        %N - кол. точек интерполяции
        %выбор файла с узловыми Х
        options.Interpreter = 'tex';
        options.Default = 'С файла'; 
        qstring = 'Каким образом произести ввод узловых точек (Х)?';
        choice = questdlg(qstring,'Окно выбора действия','С файла','Ввести вручную',options);
       switch choice
        case 'С файла'
               FileName = uigetfile('*.txt','Выбирете файл с узловыми точками Х ');
               x=dlmread(FileName);
        case 'Ввести вручную'
                  %%
                    inp = inputdlg({'Введите значения через пробел " " или запятую","'},'Введите данные',[1 40],{'3.2 4.1 9.2 7.5 2.5'});
                    x = str2num(inp{1});
                     if(isempty(inp))
                         mode = struct('WindowStyle','modal',... 
                         'Interpreter','tex');
                          h = errordlg('Программа будет перезапущена!!! Ошибка ввода функции',...
                            'Error', mode); 
                          waitfor(h);
                          close;
                     end
           otherwise
               close;
       end
         myicon = imread('warning.jpg');
         h=msgbox('.* --- ОПЕРАЦИЯ УМНОЖЕНИЯ ./ --- ОПЕРАЦИЯ ДЕЛЕНИЯ .^ --- ОПЕРАЦИЯ ВОЗВЕДЕНИЯ В СТЕПЕНЬ','Мат. операции матлаб','custom',myicon);
         waitfor(h);
         ans = inputdlg({'Интерполировать f(x):'},'Введите данные',[1 40],{'sin(x)'});
        if(isempty(ans))
            mode = struct('WindowStyle','modal',... 
            'Interpreter','tex');
            h = errordlg('Программа будет перезапущена!!! Ошибка ввода функции',...
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
    %происходит сортировка узлов по возростанию
    [x,I] = sort(x); % в столбце I получаем номера позиций    
    %для перестановки вектора у 
        y = y(I); % переставили узлы на нужные позиции
        answer = inputdlg({'Интерполировать от A_x:','До B_x:','Количество точек интерполяции'},'Введите данные',[1 40;1 40;1 40],{'2.5','9.2','2000'});
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
            h = errordlg('Перезапустите программу! Вы ввели неправильно кол. точек!',...
            'Error', mode); 
            waitfor(h);
            close;
        end;
   if(A<min(x)||B>max(x))
            mode = struct('WindowStyle','modal',... 
            'Interpreter','tex');
            h = errordlg('Обнаружены точки для интерполирования находящиеся за рамками узлового диапазона! Сузьте интервал интерполяции для продолжения работы.',...
            'Error', mode); 
            waitfor(h);
            options.Interpreter = 'tex';
            options.Default = 'Да'; 
            qstring = 'Перезапустить программу для корректности получаемого результата?';
            choice = questdlg(qstring,' Окно выбора действия ',...
            'Да','Продолжить работу',options);
    switch choice
        case 'Да'
            close;
            Menu();
        case 'Продолжить работу'
                        mode = struct('WindowStyle','modal',... 
            'Interpreter','tex');
            h = warndlg('Корректность полученных результатов вне отрезка узловых точек не гарантировано!!!','ПРЕДУПРЕЖДЕНИЕ',mode);
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
        %% Вызов интерполяционных методов
        figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);
        axes;
        whitebg('b');
         %% создание окна с пустой полосой прогресса 
            h = waitbar(0, 'Идет расчет значений ...'); 
            % поиск указателя на полигональный объект 
            hP = findobj(h, 'Type', 'patch'); 
            % задание цвета внутренности и границы полигонального объекта 
            set(hP, 'FaceColor', 'w', 'EdgeColor', 'g') 
            for i=1:1000
                waitbar(i/1000, h) 
            end 
            close(h);
        %% Вызов интерпояционных методов
        Ak=Akima(x_,y_,x,y,func);
        Cu=Cubic(x_,y_,x,y,func);
        He=Hermit(x_,y_,x,y,func);
        %% Построение точного графика
        hold on
        subplot(2, 2, 1);
        plot_1=plot(x_,y_,'--go',x,y,'r');
        title('График №1');
        xlabel('X');
        ylabel('Y');
        leg=legend('Лин. интерп.','Точное значение','Location','southeast');
        set(plot_1,'LineWidth', 5); 
        grid on;
        %% Вывод информации об расчетах 
        eps=3;
        %%
        result{1}='             ТОЧНОЕ ЗНАЧЕНИЕ';
        result{2}=['Время выполнения ==> ' mat2str(time,eps)];
        result{3}=['Кол. точек интерполяции ==> ' num2str(N)];
        result{4}=['Средне кв. откл. ==> ' num2str(0)];
        %%
        result{6}='             СПЛАЙН АКИМЫ';
        result{7}=['Время выполнения ==> ' mat2str(Ak(1),eps)];
        result{8}=['Кол. точек интерполяции ==> ' num2str(N)];
        result{9}=['Средне кв. откл. ==> ' num2str(Ak(2),eps)];
        %%
        result{11}='        СПЛАЙН КЛАС. КУБИЧЕСКИЙ';
        result{12}=['Время выполнения ==> ' mat2str(Cu(1),eps)];
        result{13}=['Кол. точек интерполяции ==> ' num2str(N)];
        result{14}=['Средне кв. откл. ==> ' num2str(Cu(2),eps)];
        %%
        result{16}='            СПЛАЙН ЭРМИТА';
        result{17}=['Время выполнения ==> ' mat2str(He(1),eps)];
        result{18}=['Кол. точек интерполяции ==> ' num2str(N)];
        result{19}=['Средне кв. откл. ==> ' num2str(He(2),eps)];
        T=msgbox(result,'Результат');
        waitfor(T);
        
        %% запись отчета в табличном виде в файл
        otc{1,1}='Название метода';
        otc{1,2}='Время выполнения';
        otc{1,3}='Кол. точек';
        otc{1,4}='Сред. кв. откл. ';
        %%
        otc{2,1}='Спл. Акимы';
        otc{2,2}=mat2str(Ak(1),eps);
        otc{2,3}=num2str(N);
        otc{2,4}=num2str(Ak(2),eps);
        %%
        otc{3,1}='Спл. Куб.';
        otc{3,2}=mat2str(Cu(1),eps);
        otc{3,3}=num2str(N);
        otc{3,4}=num2str(Cu(2),eps);
        %%
        otc{4,1}='Спл. Эрмита';
        otc{4,2}=mat2str(He(1),eps);
        otc{4,3}=num2str(N);
        otc{4,4}=num2str(He(2),eps);
        %%
        otc{5,1}='Точное знач.';
        otc{5,2}=mat2str(time,eps-4);
        otc{5,3}=num2str(N);
        otc{5,4}=num2str(0);
        xlswrite('Result',otc);
        %% Печать результата
        options.Interpreter = 'tex';
        options.Default = 'Нет';
        qstring = 'Распечатать график?';
    choice = questdlg(qstring,'Окно выбора действия ',...
        'Да','Нет',options);
    switch choice
    case 'Да'
        printdlg();
        close;
        Menu();
    case 'Нет'
        close;
        Menu();
    otherwise
        close;
        Menu();
    end
      catch
            mode = struct('WindowStyle','modal',... 
            'Interpreter','tex');
            h = errordlg('Ошибка на этапе компиляции!!!Будьте внимательны при заполнении полей и выборе файла.',...
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
          h=msgbox('Ваша ОС не подходит для приложения!!!','Исключение','custom',myicon);
          close;
          Menu();
        else
         info = CPUinfo();
         info.Name=['CPU -- ' info.Name];
         info.Clock=['Частота -- ' info.Clock];
         info.Cache=['Кэш 3-ур -- ' info.Cache];
         info.OSType=['ОС -- ' info.OSType];
         core=['Ядер -- ' mat2str(info.NumProcessors) 'x'];
         result{1}=mat2str(info.Name);
         result{2}=mat2str(info.Clock);
         result{3}=mat2str(info.Cache);
         result{4}=core;
         result{5}=mat2str(info.OSType);
         T=msgbox(result,'Результат');
         waitfor(T);
         close();
         Menu();
        end;     
        %% Об авторе
    case 3
          myicon = imread('photo.jpg');
          h=msgbox('Автор: Скрипка Богдан 335гр.Курсовая работа. Тема: "Приближение ф-ций сплайнами 3-го порядка. 2016г"','Информационное окно','custom',myicon);
          waitfor(h);
          close;
          Menu();
          %% Выход
    case 4 
        exit();
    otherwise
        close;
  end