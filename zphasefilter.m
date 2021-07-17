function [ygp ywithoutgp] = zphasefilter(h,x)
    gd = groupdelay(h,1000000);
    gd = round(mean(gd));
    y = filter(h,1,x);
    ygp = y;
    if gd > 0
        ywithoutgp = [y(1+gd:end),zeros(1,gd)];
    else
        ywithoutgp = [zeros(1,gd),y(1:end-gd)];
    end
end
