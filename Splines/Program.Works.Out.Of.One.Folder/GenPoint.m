function GenPoint(a_x,b_x,N,S)
R_x = a_x + (b_x-a_x).*rand(N,1);
dlmwrite(S,R_x);
end

    
    % вывод коэффициентов k-го полинома
%text('Position',[xx(15) yy(15)],...
     %  'String',num2str([a(k); b(k); c(k); d(k)]), 'Color', rgbcolor,...
      %  'VerticalAlignment','middle','HorizontalAlignment','center')