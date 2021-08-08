function res = fg()
tic
t='x.^2+211+21*x+21'
g=inline(t);
p=(g(4));
disp(p);
toc
p=(g(343));
disp(p);
toc
p=(g(102));
disp(p);
toc
res=toc;
SYS=evalc();
CPU=feature('GetCPU')
Core=feature('NumCores')
sysinfo=computer;
archstr=computer('arch')
[sysinfo,maxsize]=computer
disp('----------------------')
printer=feature('GetPrinterColor')
%system('start cmd')
end