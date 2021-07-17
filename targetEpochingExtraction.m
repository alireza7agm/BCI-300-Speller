function [nonTargets targets output] = targetEpochingExtraction(subject,EpochedDataSubTrain)
    targets = find(downsample(subject.targetStatus,4) == 1);
    nonTargets = find(downsample(subject.targetStatus,4) ~= 1);
    targetTrainEpoched = EpochedDataSubTrain(:,:,targets);
    nontargetTrainEpoched = EpochedDataSubTrain(:,:,nonTargets);

    output = struct('notSeparatedEpoch',EpochedDataSubTrain,'targetTrainEpoch',targetTrainEpoched,...
        'nontargetTrainEpoch',nontargetTrainEpoched);
end