function res = fg()
 answer = inputdlg({'Интерполировать f(x):'},'Введите данные',[1 40],{'x.^2'});
 inp_data=cell2str(answer);
func=inp_data(3:length(inp_data)-3);
g=inline(func);
yy=[ 1 2 3 4 5]
p=(g(yy));
disp(p);
toc

end