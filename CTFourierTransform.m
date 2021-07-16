function [Y,freq] = FourierTransform(InputSignal, Fs)
L=length(InputSignal);               % data length
freq = Fs/2*linspace(0,1,L/2+1);     % single-sided positive frequency
Y = fft(InputSignal)/L;              % normalized fft
Y = 2*abs(Y(1:L/2+1));               % one-sided amplitude spectrum
plot(freq,Y);
grid on; grid minor;
title('One-Sided Amplitude Spectrum','Interpreter','LaTeX');
xlabel('Frequency (Hz)','Interpreter','LaTeX');
ylabel('$|X(f)|$','Interpreter','LaTeX');
end