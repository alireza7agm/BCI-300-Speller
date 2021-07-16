function [y,f] = HalfBandFFT(InputSignal)
L=length(InputSignal);          % data length
freq = 2*pi/L * linspace(0,L,L);     
fftSignal = fft(InputSignal); 
fftSignal = abs(fftSignal)/(L/2);     % amplitude spectrum   

plot(freq,fftSignal);
grid on; grid minor;
title('Half Band FFT','Interpreter','LaTeX');
xlabel('$\Omega$','Interpreter','LaTeX');
ylabel('$|X(\Omega)|$','Interpreter','LaTeX');
ylim([0 max(fftSignal) + 0.01]);
xlim([0 2*pi]);
xticks(0:pi/4:2*pi);
xticklabels({'0','\pi/4','\pi/2','3\pi/4','\pi','5\pi/4','3\pi/2','7\pi/4','2\pi'})

y = fftSignal;
f = freq;
end

