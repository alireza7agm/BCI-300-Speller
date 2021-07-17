function paradigm = checkParadigm(inputSub)
    if(max(inputSub.train(10,:)) == 12)
        paradigm = 'RC';
    else
        paradigm = 'SC';
    end
end

