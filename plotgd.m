function plotgd(h,N)
    gd1 = groupdelay(h,N); % our function
    gd2 = grpdelay(h,1,N); % matlab function
    figure;
    subplot(2,1,1)
    plot(gd1)
    grid on;
    title('group delay calculated by our implementation','interpreter','Latex')
    subplot(2,1,2)
    plot(gd2)
    title('group delay calculated by Matlab function/grpdelay','interpreter','Latex')
    grid on;
end
