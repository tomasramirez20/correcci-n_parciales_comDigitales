clc; clear; close all;

%% Parámetros de la FFT y ADC
fs = 1e6;               % Frecuencia de muestreo (Hz)
M = 3990;               % Número de puntos en la FFT
Nbits = 12;             % Resolución ADC

%% Señal de prueba (senoidal a escala completa)
f0 = 20e3;                          % frecuencia de la señal (Hz)
t = (0:M-1)/fs;                     % vector de tiempo
x = 0.5*sin(2*pi*f0*t) + 0.5;       % señal con offset

%% FFT
X = fft(x, M);
X_mag = abs(X)/(M/2);               % magnitud normalizada
f = (0:M-1)*(fs/M);                 % vector de frecuencias

%% Cálculo del SNR teórico
SNR_teorico = 6.02*Nbits + 1.76;    % ≈ 74 dB

%% Gráfico del espectro
figure;
plot(f/1e3, 20*log10(X_mag), 'b');
xlabel('Frecuencia [kHz]');
ylabel('Magnitud [dB]');
title(sprintf('FFT con M = %d, SNR ≈ %.1f dB', M, SNR_teorico));
xlim([0 fs/2/1e3]); % hasta fs/2 en kHz
grid on;

%% Resultados en consola
fprintf('--- Resultados ---\n');
fprintf('Resolución ADC = %d bits\n', Nbits);
fprintf('SNR teórico    = %.2f dB\n', SNR_teorico);
fprintf('M usado (FFT)  = %d\n', M);