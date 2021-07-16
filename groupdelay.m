function gd = groupdelay(h,N)
    n = 0:size(h,2)-1;
    numerator = fft(h.*n,N); % N-point DFT
    denominator = fft(h,N);
    gd = real(numerator./denominator);
end