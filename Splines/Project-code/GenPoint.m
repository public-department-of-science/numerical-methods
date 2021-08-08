function GenPoint(a_x,b_x,a_y,b_y,N)
R_x = a_x + (b_x-a_x).*rand(N,1);
R_y = a_y + (b_y-a_y).*rand(N,1);
dlmwrite('X.txt',R_x);
dlmwrite('Y.txt',R_y);
end

    
    % вывод коэффициентов k-го полинома
%text('Position',[xx(15) yy(15)],...
     %  'String',num2str([a(k); b(k); c(k); d(k)]), 'Color', rgbcolor,...
      %  'VerticalAlignment','middle','HorizontalAlignment','center')