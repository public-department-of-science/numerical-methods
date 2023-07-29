function res = fg()
tic
t='x.^2'
g=inline(t);
p=(g(1));
disp(p);
toc
p=(g(2));
disp(p);
toc
p=(g(3));
disp(p);
toc
res=toc;
end