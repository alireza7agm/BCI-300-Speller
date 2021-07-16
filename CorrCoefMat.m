function CorrMat = CorrCoefMat(data)
    n = size(data,1);
    X1 = sum(data.*data,2);
    Xnorm = repmat(X1,1,n);
    Ynorm = Xnorm.';

    CorrMat = (data*data')./sqrt(Xnorm.*Ynorm);
end