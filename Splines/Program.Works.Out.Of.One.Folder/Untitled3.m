    hA = axes; % �������� ���� 
    % ���������� ������� 
    x = 0:0.1:10; 
    y = sin(x); 
    hL = plot(x,y) 
    hT = title('Random Graph') % ���������� ��������� 
    % �������� ����������� ���� ��� ������ ����� ����� 
    uisetcolor(hL, 'Select line color') 
    % �������� ����������� ���� ��� ������ ����� ��������� 
    uisetcolor(hT, 'Select title color') 
    % �������� ����������� ���� ��� ������ ����� ���� 
    uisetcolor(hA, 'Select axes color')
    
set(0,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
set(0,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman'); 


����� ���������� ��������� ������ ������� � ��� ��������� �� ������, ��������, � ������������ �� ���� �����:

figure('Units', 'normalized', 'OuterPosition', [0 0 1 1]);


��� ������������� ��������� �������� �������:

title('��������');


����� ����� �������� ���������� ���������� �������� � ����� ����, c �������������� ��� �� ���� � ������� �������:

hold on;%��� hold all;


������ ������� � ������������ ������, ������ � �������� �����:

plot(X2,Y2,':k','LineWidth',3);
plot(X2,Y3,':b','LineWidth',3);
plot(X2,Y4,'-.','Color',[.1 .7 .7],'LineWidth',3);
plot(X2,Y5,'--','Color',[.1 .4 .1],'LineWidth',3);
plot(X2,Y6,'r','LineWidth',3);


��������� ������� � ������ � ������������ ���������� �� �������, �������� ������ �����:

legend('�������� ������','������� 3-� �������','������� 4-� �������','������� 5-� �������','������� 7-� �������','������� 9-� �������', 4);
    
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
     
text(x(index),y(index),'\leftarrow �������� ������������');
    % �������� ���� � ������ ������� ��������� 
    h = waitbar(0, 'Solving eigenvalue problems...'); 
    % ����� ��������� �� ������������� ������ 
    hP = findobj(h, 'Type', 'patch'); 
    % ������� ����� ������������ � ������� �������������� ������� 
    set(hP, 'FaceColor', 'g', 'EdgeColor', 'g') 
    for i=1:1000 
    waitbar(i/1000, h) 
    end 
    close(h)
    
    
