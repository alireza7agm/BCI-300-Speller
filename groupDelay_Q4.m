% question 4
clc; clear; close all;

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

%%
% functions
function gd = groupdelay(h,N)
    n = 0:size(h,2)-1;
    numerator = fft(h.*n,N); % N-point DFT
    denominator = fft(h,N);
    gd = real(numerator./denominator);
end

function y = zphasefilter(h,x)
    gd = groupdelay(h,1000000);
    gd = round(mean(gd));
    y = filter(h,1,x);
    if gd > 0
        y = [y(1+gd:end),zeros(1,gd)];
    else
        y = [zeros(1,gd),y(1:end-gd)];
    end
end

function plotgd(h,N)
    gd1 = groupdelay(h,N); % our functino
    gd2 = grpdelay(h,1,N); % matlab function
    figure;
    subplot(2,1,1)
    plot(gd1)
    subplot(2,1,2)
    plot(gd2)
end