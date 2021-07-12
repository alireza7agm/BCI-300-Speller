% question 2
clc; close all; clear;
addpath('Dataset');

Subject1 = load('SubjectData1.mat');
SamplingFreq = 1/(Subject1.train(1,3) - Subject1.train(1,2))

% fourier transform - before pre processing
figure;
subplot(2,2,1);
FourierTransform(Subject1.train(2,:),SamplingFreq);
title('Fourier Transform - Channel.1 - Subject1','interpreter','latex');
subplot(2,2,2);
FourierTransform(Subject1.train(3,:),SamplingFreq);
title('Fourier Transform - Channel.2 - Subject1','interpreter','latex');
subplot(2,2,3);
FourierTransform(Subject1.train(4,:),SamplingFreq);
title('Fourier Transform - Channel.3 - Subject1','interpreter','latex');
subplot(2,2,4);
FourierTransform(Subject1.train(5,:),SamplingFreq);
title('Fourier Transform - Channel.4 - Subject1','interpreter','latex');
figure
subplot(2,2,1);
FourierTransform(Subject1.train(6,:),SamplingFreq);
title('Fourier Transform - Channel.5 - Subject1','interpreter','latex');
subplot(2,2,2);
FourierTransform(Subject1.train(7,:),SamplingFreq);
title('Fourier Transform - Channel.6 - Subject1','interpreter','latex');
subplot(2,2,3);
FourierTransform(Subject1.train(8,:),SamplingFreq);
title('Fourier Transform - Channel.7 - Subject1','interpreter','latex');
subplot(2,2,4);
FourierTransform(Subject1.train(9,:),SamplingFreq);
title('Fourier Transform - Channel.8 - Subject1','interpreter','latex');

% re-referencing to mean
subject1TrainData = Subject1.train;
subject1TrainData(2:9,:) = subject1TrainData(2:9,:) - mean(subject1TrainData(2:9,:),1);

% bandpass filter - 0.5 Hz to 50 Hz
BPfilteredSubject1TrainData = subject1TrainData(2:9,:);
BPfilteredSubject1TrainData(2,:) = bandpass(subject1TrainData(2,:),[0.5 50],SamplingFreq);
BPfilteredSubject1TrainData(3,:) = bandpass(subject1TrainData(3,:),[0.5 50],SamplingFreq);
BPfilteredSubject1TrainData(4,:) = bandpass(subject1TrainData(4,:),[0.5 50],SamplingFreq);
BPfilteredSubject1TrainData(5,:) = bandpass(subject1TrainData(5,:),[0.5 50],SamplingFreq);
BPfilteredSubject1TrainData(6,:) = bandpass(subject1TrainData(6,:),[0.5 50],SamplingFreq);
BPfilteredSubject1TrainData(7,:) = bandpass(subject1TrainData(7,:),[0.5 50],SamplingFreq);
BPfilteredSubject1TrainData(8,:) = bandpass(subject1TrainData(8,:),[0.5 50],SamplingFreq);
BPfilteredSubject1TrainData(9,:) = bandpass(subject1TrainData(9,:),[0.5 50],SamplingFreq);

% fourier transform - rereferenced/bpfiltered
figure;
subplot(2,2,1);
FourierTransform(BPfilteredSubject1TrainData(1,:),SamplingFreq);
title('Fourier Transform - Channel.1 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,2);
FourierTransform(BPfilteredSubject1TrainData(2,:),SamplingFreq);
title('Fourier Transform - Channel.2 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,3);
FourierTransform(BPfilteredSubject1TrainData(3,:),SamplingFreq);
title('Fourier Transform - Channel.3 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,4);
FourierTransform(BPfilteredSubject1TrainData(4,:),SamplingFreq);
title('Fourier Transform - Channel.4 - Subject1/RerefBp','interpreter','latex');
figure
subplot(2,2,1);
FourierTransform(BPfilteredSubject1TrainData(5,:),SamplingFreq);
title('Fourier Transform - Channel.5 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,2);
FourierTransform(BPfilteredSubject1TrainData(6,:),SamplingFreq);
title('Fourier Transform - Channel.6 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,3);
FourierTransform(BPfilteredSubject1TrainData(7,:),SamplingFreq);
title('Fourier Transform - Channel.7 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,4);
FourierTransform(BPfilteredSubject1TrainData(8,:),SamplingFreq);
title('Fourier Transform - Channel.8 - Subject1/RerefBp','interpreter','latex');


% down sampling/2
BPfilteredSubject1TrainDataDownSampled = zeros(8,65282/2);
BPfilteredSubject1TrainDataDownSampled(1,:) = downsample(BPfilteredSubject1TrainData(1,:),2);
BPfilteredSubject1TrainDataDownSampled(2,:) = downsample(BPfilteredSubject1TrainData(2,:),2);
BPfilteredSubject1TrainDataDownSampled(3,:) = downsample(BPfilteredSubject1TrainData(3,:),2);
BPfilteredSubject1TrainDataDownSampled(4,:) = downsample(BPfilteredSubject1TrainData(4,:),2);
BPfilteredSubject1TrainDataDownSampled(5,:) = downsample(BPfilteredSubject1TrainData(5,:),2);
BPfilteredSubject1TrainDataDownSampled(6,:) = downsample(BPfilteredSubject1TrainData(6,:),2);
BPfilteredSubject1TrainDataDownSampled(7,:) = downsample(BPfilteredSubject1TrainData(7,:),2);
BPfilteredSubject1TrainDataDownSampled(8,:) = downsample(BPfilteredSubject1TrainData(8,:),2);


% epoching
backwardSamples = 200; % ms
forwardSamples = 800; % ms
inputSignal = BPfilteredSubject1TrainDataDownSampled;
FsN = SamplingFreq / 2; % new Fs
StimuliTimes = find(subject1TrainData(10,:) ~= 0)./SamplingFreq;
dataEpoched = epoch(inputSignal,backwardSamples,forwardSamples,StimuliTimes,FsN);
%% functions
function FourierTransform(inputSignal,Fs)
    S = inputSignal;
    L = length(S);
    Y = fft(S);
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs*(0:(L/2))/L;
    plot(f,P1)
    grid on; grid minor;
    title('One-Sided Amplitude Spectrum','Interpreter','LaTeX');
    xlabel('w','Interpreter','LaTeX');
    ylabel('$|$X(w)$|$','Interpreter','LaTeX');
end


function dataEpoched = epoch(inputSignal,backwardSamples,forwardSamples,StimuliTimes,Fs)
    numberOfChannels = 8;
    time = backwardSamples + forwardSamples; % ms
    dataEpoched = zeros(numberOfChannels,time/1000*Fs,length(StimuliTimes));
    for i=1:length(StimuliTimes)
        dataEpoched(:,:,i) = inputSignal(:,((StimuliTimes(1,i)-backwardSamples/1000)*Fs+1):((StimuliTimes(1,i)+forwardSamples/1000))*Fs);
    end
end

