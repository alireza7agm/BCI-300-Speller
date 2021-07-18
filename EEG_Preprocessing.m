% question 2
function [SamplingFreq BPfilteredSubjectData dataEpoched] = EEG_Preprocessing(Subject,Method)
    warning('off');
    addpath('Dataset');
    

    % re-referencing to mean
    if(strcmp(Method,'train') == 1)
        SubjectData = Subject.train;
    else
        SubjectData = Subject.test;
    end
    
    SamplingFreq = 1/(SubjectData(1,3) - SubjectData(1,2))
    SubjectData(2:9,:) = SubjectData(2:9,:) - mean(SubjectData(2:9,:),1);

    % bandpass filter - 0.5 Hz to 50 Hz
    BPfilteredSubjectData = SubjectData(2:9,:);
    BPfilteredSubjectData(1,:) = bandpass(SubjectData(2,:),[0.5 40],SamplingFreq);
    BPfilteredSubjectData(2,:) = bandpass(SubjectData(3,:),[0.5 40],SamplingFreq);
    BPfilteredSubjectData(3,:) = bandpass(SubjectData(4,:),[0.5 40],SamplingFreq);
    BPfilteredSubjectData(4,:) = bandpass(SubjectData(5,:),[0.5 40],SamplingFreq);
    BPfilteredSubjectData(5,:) = bandpass(SubjectData(6,:),[0.5 40],SamplingFreq);
    BPfilteredSubjectData(6,:) = bandpass(SubjectData(7,:),[0.5 40],SamplingFreq);
    BPfilteredSubjectData(7,:) = bandpass(SubjectData(8,:),[0.5 40],SamplingFreq);
    BPfilteredSubjectData(8,:) = bandpass(SubjectData(9,:),[0.5 40],SamplingFreq);


    % down sampling/2
    tmpBPfilteredSubjectDataDownSampled = (BPfilteredSubjectData(1:8,:)).';
    BPfilteredSubjectDataDownSampled = (downsample(tmpBPfilteredSubjectDataDownSampled,2)).';

    % epoching
    backwardSamples = 200; % ms
    forwardSamples = 800; % ms
    inputSignal = BPfilteredSubjectDataDownSampled;
    FsN = SamplingFreq / 2; % new Fs
    StimuliTimes = downsample(find(SubjectData(10,:) ~= 0)./SamplingFreq,4);
    dataEpoched = epoch(inputSignal,backwardSamples,forwardSamples,StimuliTimes,FsN);
end
