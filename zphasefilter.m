function y = zphasefilter(h,x)
    gd = groupdelay(h,1000000);
    gd = round(mean(gd));
    y = filter(h,1,x);
    if gd > 0
        y = [y(1+gd:end),zeros(1,gd)];
    else
        y = [zeros(1,gd),y(1:end-gd)];
    end
end
