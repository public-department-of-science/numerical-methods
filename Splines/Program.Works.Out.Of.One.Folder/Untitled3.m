    hA = axes; % создание осей 
    % построение графика 
    x = 0:0.1:10; 
    y = sin(x); 
    hL = plot(x,y) 
    hT = title('Random Graph') % добавление заголовка 
    % открытие диалогового окна для выбора цвета линии 
    uisetcolor(hL, 'Select line color') 
    % открытие диалогового окна для выбора цвета заголовка 
    uisetcolor(hT, 'Select title color') 
    % открытие диалогового окна для выбора цвета осей 
    uisetcolor(hA, 'Select axes color')
    
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 


Затем необходимо настроить размер графика и его положение на экране, например, с отображением на весь экран:

figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);


При необходимости вставляем название графика:

title('Название');


Далее можно включить построение нескольких графиков в одном окне, c использованием тех же осей и свойств графика:

hold on;%или hold all;


Строим графики с определенным цветом, стилем и толщиной линии:

plot(X2,Y2,':k','LineWidth',3);
plot(X2,Y3,':b','LineWidth',3);
plot(X2,Y4,'-.','Color',[.1 .7 .7],'LineWidth',3);
plot(X2,Y5,'--','Color',[.1 .4 .1],'LineWidth',3);
plot(X2,Y6,'r','LineWidth',3);


Вставляем легенду в график с определенным положением на рисунке, например справа внизу:

legend('исходные данные','полином 3-й степени','полином 4-й степени','полином 5-й степени','полином 7-й степени','полином 9-й степени', 4);
    
t = -pi:pi/100:pi;
y = sin(t);
plot(t,y)
axis([-pi pi -1 1])
xlabel( ' -\pi \leq \itt \leq \pi ' )
ylabel( ' sin(t) ' )
WLWOH 
 =jZnbd nmgdpbb VLQ 
 
text(-1  
 ?LW^Hlf_lvl_ g_q_lgmx kbff_ljbx` 
 
 set( hPlot, 'LineWidth', 7 ); 
 whitebg('y') 
 
 p = rand(10,2);
labels = cellstr( num2str([1:10]') );  %' # labels correspond to their order
 
plot(p(:,1), p(:,2), 'rx')
text(p(:,1), p(:,2), labels, 'VerticalAlignment','bottom', 'HorizontalAlignment','right')
     
text(x(index),y(index),'\leftarrow Линейная интерполяция');
    % создание окна с пустой полосой прогресса 
    h = waitbar(0, 'Solving eigenvalue problems...'); 
    % поиск указателя на полигональный объект 
    hP = findobj(h, 'Type', 'patch'); 
    % задание цвета внутренности и границы полигонального объекта 
    set(hP, 'FaceColor', 'g', 'EdgeColor', 'g') 
    for i=1:1000 
    waitbar(i/1000, h) 
    end 
    close(h)
    
    
