function res=Hermit_sp(x,y,XX,YY,func)
g=inline(func);
%% ���� ������
tic
% n ���������� ����� ��������� ���������������� ������� �������
%������� ������� ����������������
y1=diff(y)./diff(x);
y1=[y1(1) y1];
% ������ ����� ���(����� ����� ��� ��������� ������������)
xx = dlmread('X.txt');
%�� ������ ������� ��������(������ ��������)�����. ������ �� 
%���������� ���������� ����� �� ����������� 
xx = sort(xx); % � ������� I �������� ������ �������
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ����������� ����� ������� �����
n=length(x);
% ���������� ���� ������������� a(k) � b(k)
a = y;
b = y1;
% ���������� ����������� ��������� 
DivDif = diff(y)./diff(x);
% ���������� ���� ������������� c(k) � d(k)
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
    % ���������� k-�� �������� � col_point ������ ����� x(k) � x(k+1)
    xx=linspace(x(k),x(k+1),col_point);
    yy=a(k) + b(k)*(xx-x(k)) + c(k)*(xx-x(k)).^2 + d(k)*(xx-x(k)).^3;
    Y=[Y yy];
    X=[X xx];
 end
for i=1:length(yy)
    error(i)=power((yy(i)-g(xx(i))),2);
end
Er=sum(error)/length(error);
%% �������� �������

    plot_1= plot(x,y,'s',XX,YY,':g',X,Y,'r');
    xlabel('X');
    ylabel('Y');
    title('������ �4');
    leg=legend('������� �����','������ ��������','������� ������','Location','southeast');  
    set(plot_1,'LineWidth', 5 ); 
grid on;
%%
dlmwrite('Y_Hermit.txt',yy);
time=toc
res=[ time Er]
end