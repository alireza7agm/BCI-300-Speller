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
EpchedData = EEG_Preprocessing();

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
SSE = Elbow_Method(data,'UPGMA');
plot(1:size(data,1), SSE);
grid on; grid minor;
title('SSE of clustering','Interpreter','LateX');
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

plot_topography(channel_title,channelClusterNum,true,'10-20',false,true, 1000);


%% Section 2 : Clustering on 8-Channel Data
data = EEG_Preprocessing();
data = mean(data,3);

clusters = CorrelationClustering(data, 'WPGMA', 4);

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
