function res=Hermit_sp(x,y,XX,YY,func)
g=inline(func);
%% Тело метода
tic
% n количество точек разбиения интерполируемого участка функции
%задание функции интерполирования
y1=diff(y)./diff(x);
y1=[y1(1) y1];
% задаем точку или(набор точек для подальшей интерполяции)
xx = dlmread('X.txt');
%на выходе получим значение(вектор значений)соотв. точкам хх 
%происходит сортировка узлов по возростанию 
xx = sort(xx); % в столбце I получаем номера позиций
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% определение числа узловых точек
n=length(x);
% нахождение всех коэффициентов a(k) и b(k)
a = y;
b = y1;
% вычисление разделенных разностей 
DivDif = diff(y)./diff(x);
% вычисление всех коэффициентов c(k) и d(k)
for k = 1:n-1
    c(k) = (3*DivDif(k) - 2*y1(k) - y1(k+1))/(x(k+1)-x(k));
    d(k) = (y1(k) - 2*DivDif(k) + y1(k+1))/(x(k+1)-x(k))^2;
end
subplot(2, 2, 4);
    hold on;
    col_point=round(length(xx)/(length(x)-1));
    Y = [];
    X = [];
 for k=1:n-1
    % вычисление k-го полинома в col_point точках между x(k) и x(k+1)
    xx=linspace(x(k),x(k+1),col_point);
    yy=a(k) + b(k)*(xx-x(k)) + c(k)*(xx-x(k)).^2 + d(k)*(xx-x(k)).^3;
    Y=[Y yy];
    X=[X xx];
 end
for i=1:length(yy)
    error(i)=power((yy(i)-g(xx(i))),2);
end
Er=sum(error)/length(error);
%% Создание графика

    plot_1= plot(x,y,'s',XX,YY,':g',X,Y,'r');
    xlabel('X');
    ylabel('Y');
    title('График №4');
    leg=legend('Узловые точки','Точное значение','Эрмитов сплайн','Location','southeast');  
    set(plot_1,'LineWidth', 5 ); 
grid on;
%%
dlmwrite('Y_Hermit.txt',yy);
time=toc
res=[ time Er]
end