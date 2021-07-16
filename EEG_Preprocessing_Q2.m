% question 2
clc; close all; clear;
addpath('Dataset');

Subject1 = load('SubjectData1.mat');
SamplingFreq = 1/(Subject1.train(1,3) - Subject1.train(1,2))

% fourier transform - before pre processing
figure;
subplot(2,2,1);
CTFourierTransform(Subject1.train(2,:),SamplingFreq);
title('Fourier Transform - Channel.1 - Subject1','interpreter','latex');
subplot(2,2,2);
CTFourierTransform(Subject1.train(3,:),SamplingFreq);
title('Fourier Transform - Channel.2 - Subject1','interpreter','latex');
subplot(2,2,3);
CTFourierTransform(Subject1.train(4,:),SamplingFreq);
title('Fourier Transform - Channel.3 - Subject1','interpreter','latex');
subplot(2,2,4);
CTFourierTransform(Subject1.train(5,:),SamplingFreq);
title('Fourier Transform - Channel.4 - Subject1','interpreter','latex');
figure
subplot(2,2,1);
CTFourierTransform(Subject1.train(6,:),SamplingFreq);
title('Fourier Transform - Channel.5 - Subject1','interpreter','latex');
subplot(2,2,2);
CTFourierTransform(Subject1.train(7,:),SamplingFreq);
title('Fourier Transform - Channel.6 - Subject1','interpreter','latex');
subplot(2,2,3);
CTFourierTransform(Subject1.train(8,:),SamplingFreq);
title('Fourier Transform - Channel.7 - Subject1','interpreter','latex');
subplot(2,2,4);
CTFourierTransform(Subject1.train(9,:),SamplingFreq);
title('Fourier Transform - Channel.8 - Subject1','interpreter','latex');

% re-referencing to mean
subject1TrainData = Subject1.train;
subject1TrainData(2:9,:) = subject1TrainData(2:9,:) - mean(subject1TrainData(2:9,:),1);

% bandpass filter - 0.5 Hz to 50 Hz
BPfilteredSubject1TrainData = subject1TrainData(2:9,:);
BPfilteredSubject1TrainData(1,:) = bandpass(subject1TrainData(2,:),[0.5 40],SamplingFreq);
BPfilteredSubject1TrainData(2,:) = bandpass(subject1TrainData(3,:),[0.5 40],SamplingFreq);
BPfilteredSubject1TrainData(3,:) = bandpass(subject1TrainData(4,:),[0.5 40],SamplingFreq);
BPfilteredSubject1TrainData(4,:) = bandpass(subject1TrainData(5,:),[0.5 40],SamplingFreq);
BPfilteredSubject1TrainData(5,:) = bandpass(subject1TrainData(6,:),[0.5 40],SamplingFreq);
BPfilteredSubject1TrainData(6,:) = bandpass(subject1TrainData(7,:),[0.5 40],SamplingFreq);
BPfilteredSubject1TrainData(7,:) = bandpass(subject1TrainData(8,:),[0.5 40],SamplingFreq);
BPfilteredSubject1TrainData(8,:) = bandpass(subject1TrainData(9,:),[0.5 40],SamplingFreq);

% fourier transform - rereferenced/bpfiltered
figure;
subplot(2,2,1);
CTFourierTransform(BPfilteredSubject1TrainData(1,:),SamplingFreq);
title('Fourier Transform - Channel.1 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,2);
CTFourierTransform(BPfilteredSubject1TrainData(2,:),SamplingFreq);
title('Fourier Transform - Channel.2 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,3);
CTFourierTransform(BPfilteredSubject1TrainData(3,:),SamplingFreq);
title('Fourier Transform - Channel.3 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,4);
CTFourierTransform(BPfilteredSubject1TrainData(4,:),SamplingFreq);
title('Fourier Transform - Channel.4 - Subject1/RerefBp','interpreter','latex');
figure
subplot(2,2,1);
CTFourierTransform(BPfilteredSubject1TrainData(5,:),SamplingFreq);
title('Fourier Transform - Channel.5 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,2);
CTFourierTransform(BPfilteredSubject1TrainData(6,:),SamplingFreq);
title('Fourier Transform - Channel.6 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,3);
CTFourierTransform(BPfilteredSubject1TrainData(7,:),SamplingFreq);
title('Fourier Transform - Channel.7 - Subject1/RerefBp','interpreter','latex');
subplot(2,2,4);
CTFourierTransform(BPfilteredSubject1TrainData(8,:),SamplingFreq);
title('Fourier Transform - Channel.8 - Subject1/RerefBp','interpreter','latex');


% down sampling/2
tmpBPfilteredSubject1TrainDataDownSampled = (BPfilteredSubject1TrainData(1:8,:)).';
BPfilteredSubject1TrainDataDownSampled = (downsample(tmpBPfilteredSubject1TrainDataDownSampled,2)).';

% epoching
backwardSamples = 200; % ms
forwardSamples = 800; % ms
inputSignal = BPfilteredSubject1TrainDataDownSampled;
FsN = SamplingFreq / 2; % new Fs
StimuliTimes = find(subject1TrainData(10,:) ~= 0)./SamplingFreq;
dataEpoched = epoch(inputSignal,backwardSamples,forwardSamples,StimuliTimes,FsN);



