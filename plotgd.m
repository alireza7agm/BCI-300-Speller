function plotgd(h,N)
    gd1 = groupdelay(h,N); % our functino
    gd2 = grpdelay(h,1,N); % matlab function
    figure;
    subplot(2,1,1)
    plot(gd1)
    subplot(2,1,2)
    plot(gd2)
end