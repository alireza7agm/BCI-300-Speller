function dataEpoched = epoch(inputSignal,backwardSamples,forwardSamples,StimuliTimes,Fs)
    numberOfChannels = 8;
    time = backwardSamples + forwardSamples; % ms
    dataEpoched = zeros(numberOfChannels,time/1000*Fs,length(StimuliTimes));
    for i=1:length(StimuliTimes)
        dataEpoched(:,:,i) = inputSignal(:,((StimuliTimes(1,i)-backwardSamples/1000)*Fs+1):((StimuliTimes(1,i)+forwardSamples/1000))*Fs);
    end
end