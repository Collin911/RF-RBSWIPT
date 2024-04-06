function C = Cal_spectral_efficiency(SNR, Delta, Cmax)
temp = 0.1 .* (SNR - Delta);
temp = 1 + 10 .^ temp;
C = log(temp) ./ log(2);
for i = 1:length(C)
    C(i) = min(C(i), Cmax);
end

end