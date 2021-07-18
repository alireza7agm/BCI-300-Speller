%% ////////////////////Part 1 - Correlation Clustering\\\\\\\\\\\\\\\\\\\\\
clc; clear; close all;
%% Section 1 : Half Band FFT
n = 0:99;
a = 0.8; 
x = a.^n;  %x[n] = a^n u[n]  => X(w) = 1/(1-ae^(-jw))
[Y, w] = HalfBandFFT(x);
xlim([0 pi]);
legend('a = 0.8', 'Interpreter', 'LaTeX')
%% Section 2 : Aliasing
clear; clc; close all;

Fs = 200;
t = 0:1/Fs:100-1/Fs;
%fmax = 70 < Fs/2 = 100   => Nyquist is preserved
x = 1/2*sin(2*pi*30*t)+cos(2*pi*70*t);
figure;
HalfBandFFT(x);

%Fs'/2 = 50 < fmax = 70   => Nyquist is not preserved
Xd = downsample(x,2); 
figure;
HalfBandFFT(Xd);
title('$X_d(\Omega)$');
%% //////////////////////Part 2 - EEG Preprocessing\\\\\\\\\\\\\\\\\\\\\\\\
clc; clear; close all;

% load data
Subject = load('SubjectData1.mat');
[SamplingFreq BPfilteredSubjectTrainData EpochedData] = EEG_Preprocessing(Subject,'train');

% fourier transform - before pre processing
figure;
subplot(2,2,1);
CTFourierTransform(Subject.train(2,:),SamplingFreq);
title('Fourier Transform - Channel.1 - Subject','interpreter','latex');
subplot(2,2,2);
CTFourierTransform(Subject.train(3,:),SamplingFreq);
title('Fourier Transform - Channel.2 - Subject','interpreter','latex');
subplot(2,2,3);
CTFourierTransform(Subject.train(4,:),SamplingFreq);
title('Fourier Transform - Channel.3 - Subject','interpreter','latex');
subplot(2,2,4);
CTFourierTransform(Subject.train(5,:),SamplingFreq);
title('Fourier Transform - Channel.4 - Subject','interpreter','latex');
figure
subplot(2,2,1);
CTFourierTransform(Subject.train(6,:),SamplingFreq);
title('Fourier Transform - Channel.5 - Subject','interpreter','latex');
subplot(2,2,2);
CTFourierTransform(Subject.train(7,:),SamplingFreq);
title('Fourier Transform - Channel.6 - Subject','interpreter','latex');
subplot(2,2,3);
CTFourierTransform(Subject.train(8,:),SamplingFreq);
title('Fourier Transform - Channel.7 - Subject','interpreter','latex');
subplot(2,2,4);
CTFourierTransform(Subject.train(9,:),SamplingFreq);
title('Fourier Transform - Channel.8 - Subject','interpreter','latex');

% fourier transform - rereferenced/bpfiltered
figure;
subplot(2,2,1);
CTFourierTransform(BPfilteredSubjectTrainData(1,:),SamplingFreq);
title('Fourier Transform - Channel.1 - Subject/RerefBp','interpreter','latex');
subplot(2,2,2);
CTFourierTransform(BPfilteredSubjectTrainData(2,:),SamplingFreq);
title('Fourier Transform - Channel.2 - Subject/RerefBp','interpreter','latex');
subplot(2,2,3);
CTFourierTransform(BPfilteredSubjectTrainData(3,:),SamplingFreq);
title('Fourier Transform - Channel.3 - Subject/RerefBp','interpreter','latex');
subplot(2,2,4);
CTFourierTransform(BPfilteredSubjectTrainData(4,:),SamplingFreq);
title('Fourier Transform - Channel.4 - Subject/RerefBp','interpreter','latex');
figure
subplot(2,2,1);
CTFourierTransform(BPfilteredSubjectTrainData(5,:),SamplingFreq);
title('Fourier Transform - Channel.5 - Subject/RerefBp','interpreter','latex');
subplot(2,2,2);
CTFourierTransform(BPfilteredSubjectTrainData(6,:),SamplingFreq);
title('Fourier Transform - Channel.6 - Subject/RerefBp','interpreter','latex');
subplot(2,2,3);
CTFourierTransform(BPfilteredSubjectTrainData(7,:),SamplingFreq);
title('Fourier Transform - Channel.7 - Subject/RerefBp','interpreter','latex');
subplot(2,2,4);
CTFourierTransform(BPfilteredSubjectTrainData(8,:),SamplingFreq);
title('Fourier Transform - Channel.8 - Subject/RerefBp','interpreter','latex');



%% ////////////////////Part 3 - Correlation Clustering\\\\\\\\\\\\\\\\\\\\\
clc; close all;
%% Section 1 : Clustering on 63-channel Data
data = double(load('64channeldata.mat').data);
data = mean(data,3);

%Check whether filtering is needed for random data channel
CTFourierTransform(data(20,:),600);
title('Frequency Spectrum of Channel 20');

%Downsample the data by rate 4, so nyquist condition is preserved
tmpData = data.';
data = downsample(tmpData , 4);
data = data.';

%Finding the optimal number of clusters
figure;
SSE = Elbow_Method(data,'UPGMA');
plot(1:size(data,1), SSE);
grid on; grid minor;
title('SSE of clustering using UPGMA method','Interpreter','LateX');
xlabel('Number of clusters','Interpreter','LateX');
ylabel('Distances','Interpreter','LateX');

clusterNum = 10;
clusters = CorrelationClustering(data, 'UPGMA', clusterNum);

channel_title = {'AFZ','FP1','FP2','AF3','AF4','F7','F3','FZ','F4','F8','FC5','FC1','FC2','FC6','T7','C3','CZ',...
    'C4','T8','CP5','CP1','CP2','CP6','P7','P3','PZ','P4','P8','PO3','PO4','O1','O2','FT10','AF7','AF8','F5',...
    'F1','F2','F6','FT7','FC3','FCZ','FC4','FT8','C5','C1','C2','C6','TP7','CP3','CPZ','CP4','TP8','P5','P1','P2','P6',...
    'PO7','POZ','PO8','OZ','TP9','TP10'};

channelClusterNum = zeros(1,size(data,1));
for i=1:clusterNum
    channelsOfCluster = clusters{i};
    for j=1:length(channelsOfCluster)
        channelClusterNum(channelsOfCluster(j)) = 10*i;
    end
end
figure;
plot_topography(channel_title,channelClusterNum,true,'10-20',false,true, 1000);


%% Section 2 : Clustering on 8-Channel Data
Subject1Data = load('SubjectData1.mat');
[~,~,data] = EEG_Preprocessing(Subject1Data,'train');
data = mean(data,3);

%Finding the optimal number of clusters
figure;
SSE = Elbow_Method(data,'UPGMA');
plot(1:size(data,1), SSE);
grid on; grid minor;
title('SSE of clustering using UPGMA method','Interpreter','LateX');
xlabel('Number of clusters','Interpreter','LateX');
ylabel('Distances','Interpreter','LateX');

clusters = CorrelationClustering(data, 'UPGMA',4);

%% /////////////////////////Part 4 - Filter Design\\\\\\\\\\\\\\\\\\\\\\\\\
clc; close all; clear;
%% Section 1 : Plot Group Delay
addpath('Filter');
h = load('BPfilter.mat').Num;
N = 1000000; %N-point DFT
plotgd(h,N);
%% Section 2 : Z-Phase Filter
figure
addpath('Filter');
h = load('BPfilter.mat').Num;
N = 1000000; %N-point DFT
signal = 0.5.*randi(100,1,N);
x = signal;


x2 = filtfilt(h,1,signal);
[x3gp x3] = zphasefilter(h,signal);

subplot(2,1,1);
plot(x3gp(1:1000));
title('filtered with the bp filter - gp available');

subplot(2,1,2)
plot(x2(1:300))
title('filtered by zphasefilter\filtfilt Matlab function','interpreter','Latex')
hold on
plot(x3(1:300));
grid on;
legend('filtfilt','zphasefilter')

%% ///////////////////////Part 5 - Word Recognition\\\\\\\\\\\\\\\\\\\\\\\\
clc; close all; clear;
%% Section 1
% part.1 
addpath('Dataset');
% load data
sub1 = load('SubjectData1.mat');
sub2 = load('SubjectData2.mat');
sub3 = load('SubjectData3.mat');
sub5 = load('SubjectData5.mat');
sub6 = load('SubjectData6.mat');
sub7 = load('SubjectData7.mat');
sub8 = load('SubjectData8.mat');
sub9 = load('SubjectData9.mat');

% experiment paradigm 
subParadigm = checkParadigm(sub1)

% part.3 - target and non-target/index extarction
% initilize a struct for all subjects
subject = struct('subject1',sub1,'subject2',sub2,'subject3',sub3,'subject5',sub5,...
    'subject6',sub6,'subject7',sub7,'subject8',sub8,'subject9',sub9);

% index extraction - number of samples when the screen bright a number or a
% column/row and target status % target = 1; nontarget = -1
subject = indexExtraction(subject);

% epoch the data for the subject
% subject 1 epoching
[~, ~, EpochedDataSub1Train] = EEG_Preprocessing(subject.subject1,'train');
[~, ~, EpochedDataSub1Test] = EEG_Preprocessing(subject.subject1,'test');

% subject 2 epoching
[~, ~, EpochedDataSub2Train] = EEG_Preprocessing(subject.subject2,'train');
[~, ~, EpochedDataSub2Test] = EEG_Preprocessing(subject.subject2,'test');

% subject 3 epoching
[~, ~, EpochedDataSub3Train] = EEG_Preprocessing(subject.subject3,'train');
[~, ~, EpochedDataSub3Test] = EEG_Preprocessing(subject.subject3,'test');

% subject 5 epoching
[~, ~, EpochedDataSub5Train] = EEG_Preprocessing(subject.subject5,'train');
[~, ~, EpochedDataSub5Test] = EEG_Preprocessing(subject.subject5,'test');

% subject 6 epoching
[~, ~, EpochedDataSub6Train] = EEG_Preprocessing(subject.subject6,'train');
[~, ~, EpochedDataSub6Test] = EEG_Preprocessing(subject.subject6,'test');

% subject 7 epoching
[~, ~, EpochedDataSub7Train] = EEG_Preprocessing(subject.subject7,'train');
[~, ~, EpochedDataSub7Test] = EEG_Preprocessing(subject.subject7,'test');

% subject 8 epoching
[~, ~, EpochedDataSub8Train] = EEG_Preprocessing(subject.subject8,'train');
[~, ~, EpochedDataSub8Test] = EEG_Preprocessing(subject.subject8,'test');

% subject 9 epoching
[~, ~, EpochedDataSub9Train] = EEG_Preprocessing(subject.subject9,'train');
[~, ~, EpochedDataSub9Test] = EEG_Preprocessing(subject.subject9,'test');


% seperate targets and non-targets in train epoches
[nontargets1 targets1 EpochedDataSub1Train] = targetEpochingExtraction(subject.subject1,EpochedDataSub1Train); % sub 1
[nontargets2 targets2 EpochedDataSub2Train] = targetEpochingExtraction(subject.subject2,EpochedDataSub2Train); % sub 2
[nontargets3 targets3 EpochedDataSub3Train] = targetEpochingExtraction(subject.subject3,EpochedDataSub3Train); % sub 3
[nontargets5 targets5 EpochedDataSub5Train] = targetEpochingExtraction(subject.subject5,EpochedDataSub5Train); % sub 5
[nontargets6 targets6 EpochedDataSub6Train] = targetEpochingExtraction(subject.subject6,EpochedDataSub6Train); % sub 6
[nontargets7 targets7 EpochedDataSub7Train] = targetEpochingExtraction(subject.subject7,EpochedDataSub7Train); % sub 7
[nontargets8 targets8 EpochedDataSub8Train] = targetEpochingExtraction(subject.subject8,EpochedDataSub8Train); % sub 8
[nontargets9 targets9 EpochedDataSub9Train] = targetEpochingExtraction(subject.subject9,EpochedDataSub9Train); % sub 9

%% Section 2 - Machine Learning Algorithm

% create a Train/Test-features matrix for a sample object: Subject 8

% labels
size1 = size(EpochedDataSub8Train.notSeparatedEpoch,1);
size2 = size(EpochedDataSub8Train.notSeparatedEpoch,2);
size3 = size(EpochedDataSub8Train.notSeparatedEpoch,3);
lenTarget = size(EpochedDataSub8Train.targetTrainEpoch,3);
lennonTarget = size(EpochedDataSub8Train.nontargetTrainEpoch,3);

label = cell(size3,1);
label(targets8) = {'target'};
label(nontargets8) = {'non-target'};


% feature matrix 
% trainFeatures = zeros(size3,size1*size2);
trainFeatures = reshape(permute(EpochedDataSub8Train.notSeparatedEpoch,[2 1 3]),[size1*size2,size3]).';
testFeatures = reshape(permute(EpochedDataSub8Test,[2 1 3]),[size1*size2,size3]).';
% trainFeatures = [(reshape(permute(EpochedDataSub8Train.targetTrainEpoch,[2 1 3]),[size1*size2,lenTarget])).';... 
    %(reshape(permute(EpochedDataSub8Train.nontargetTrainEpoch,[2 1 3]),[size1*size2,lennonTarget])).'];

XX1 = fitcdiscr(trainFeatures,label);
XX2 = fitcsvm(trainFeatures,label);
% train
output1labelsTrain = predict(XX1,trainFeatures);
output2labelsTrain = predict(XX2,trainFeatures);
% test
output1labelsTest = predict(XX1,testFeatures);
output2labelsTest = predict(XX2,testFeatures);
% print the word - Train
outputWordTrain1 = createWord(output1labelsTrain,sub8.train(10,downsample(find(sub8.train(10,:) ~= 0),4)),'RC')
outputWordTrain2 = createWord(output2labelsTrain,sub8.train(10,downsample(find(sub8.train(10,:) ~= 0),4)),'RC')
% print the word - Test
outputWordTest1 = createWord(output1labelsTest,sub8.test(10,downsample(find(sub8.test(10,:) ~= 0),4)),'RC')
outputWordTest2 = createWord(output2labelsTest,sub8.test(10,downsample(find(sub8.test(10,:) ~= 0),4)),'RC')
