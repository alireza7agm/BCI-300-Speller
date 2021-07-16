%% ////////////////////Part 1 - Correlation Clustering\\\\\\\\\\\\\\\\\\\\\
clc; clear; close all;
%% Section 1 : Half Band FFT
n = 0:99;
a = 0.8; 
x = a.^n;  %x[n] = a^n u[n]  => X(w) = 1/(1-ae^(-jw))
[Y, w] = HalfBandFFT(x);

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
%% //////////////////////Part 2 - EEG Preprocessing\\\\\\\\\\\]\\\\\\\\\\\\

%% ////////////////////Part 3 - Correlation Clustering\\\\\\\\\\\\\\\\\\\\\
clc; close all;
%% Section 1 : Clustering on 63-channel Data
data = double(load('Data\64channeldata.mat').data);
data = mean(data,3);

%Check whether filtering is needed for random data channel
CTFourierTransform(data(37,:),600);

%Downsample the data by rate 4, so nyquist condition is preserved
tmpData = data.';
data = downsample(tmpData , 4);
data = data.';

clusters = CorrelationClustering(data, 'UPGMA', 10);

channel_title = {'AFZ','FP1','FP2','AF3','AF4','F7','F3','FZ','F4','F8','FC5','FC1','FC2','FC6','T7','C3','CZ',...
    'C4','T8','CP5','CP1','CP2','CP6','P7','P3','PZ','P4','P8','PO3','PO4','O1','O2','FT10','AF7','AF8','F5',...
    'F1','F2','F6','FT7','FC3','FCZ','FC4','FT8','C5','C1','C2','C6','TP7','CP3','CPZ','CP4','TP8','P5','P1','P2','P6',...
    'PO7','POZ','PO8','OZ','TP9','TP10'};

channelPower = zeros(1,size(data,1));
for i=1:clusterNum
    channelsOfCluster = clusters{i};
    for j=1:length(channelsOfCluster)
        channelPower(channelsOfCluster(j)) = 10*i;
    end
end

plot_topography(channel_title,channel,true,'10-20',false,true, 1000);

%% Section 2 : Clustering on 8-Channel Data
data = EEG_Preprocessing();
data = mean(data,3);

clusters = CorrelationClustering(data, 'WPGMA', 4);

%% /////////////////////////Part 4 - Filter Design\\\\\\\\\\\\\\\\\\\\\\\\\
clc; close all; clear;
h = load('BPfilter.mat').Num;
N = 1000000; %N-point DFT
plotgd(h,N);
gd1 = groupdelay(h,N);
gd2 = grpdelay(h,1,N);

figure
signal = randi(100,1,N);
x = signal;
subplot(2,1,1)
plot(x(1:300))

subplot(2,1,2)
x2 = filtfilt(h,1,signal);
plot(x2(1:300))
hold on
x3 = zphasefilter(h,signal);
plot(x3(1:300));