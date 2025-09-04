% Reconstrucción de señal periódica y cálculo de ciclo útil y frecuencia
clc; clear; close all;

%% Parámetros de la señal
V = 5;              % Amplitud del pulso (Voltios)
T = 10e-6;          % Período de la señal (10 us -> f = 100 kHz aprox.)
tau = 2e-6;         % Ancho de pulso (2 us)
f0 = 1/T;           % Frecuencia fundamental

%% Tiempo de simulación
t = linspace(0, 2*T, 1000); % dos periodos

%% Número de armónicos a usar en la reconstrucción
N = 20;

%% Serie de Fourier para reconstrucción
v_recon = (V*tau/T) * ones(size(t)); % Componente DC
for n = 1:N
    cn = (2*V/(n*pi)) * sin(n*pi*tau/T); % Coeficiente de Fourier
    v_recon = v_recon + cn * cos(2*pi*n*f0*t);
end

%% Señal original (pulso cuadrado ideal para comparación)
v_original = V*(square(2*pi*f0*t, (tau/T)*100)+1)/2;

%% Cálculo de ciclo útil y frecuencia
f = 1/T;
duty_cycle = (tau/T) * 100;

fprintf('Frecuencia de la señal: %.2f kHz\n', f/1e3);
fprintf('Ciclo útil de la señal: %.2f %%\n', duty_cycle);

%% Gráficas
figure;

plot(t*1e6, v_original, 'k', 'LineWidth', 1.5); hold on;
plot(t*1e6, v_recon, 'r--', 'LineWidth', 1.5);
xlabel('Tiempo [us]');
ylabel('Voltaje [V]');
title('Reconstrucción de la señal con Serie de Fourier');
legend('Señal original','Señal reconstruida');
grid on;

%% Espectro de magnitudes de los armónicos
n = 1:N;
Cn = (2*V./(n*pi)) .* sin(n*pi*tau/T); % Magnitudes armónicas