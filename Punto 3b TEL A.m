%PUNTO3B
clc; clear; close all;

%% Parámetros de la señal
T = 10e-6;        % Periodo (10 us)
tau = 2e-6;       % Ancho de pulso (2 us)
V = 1;            % Amplitud del pulso
N = 10;           % Número de armónicos a calcular

%% Cálculo del ciclo útil
D = tau / T;      % Duty Cycle
fprintf('Duty Cycle = %.2f %%\n', D*100);

%% Frecuencia fundamental
f0 = 1/T;

%% Coeficientes de Fourier (Magnitud de armónicos)
n = 1:N;
Vn = (2*V*tau/T) .* (sin(n*pi*tau/T) ./ (n*pi*tau/T));

%% Mostrar resultados
fprintf('\nFrecuencias y Amplitudes de los primeros 10 armónicos:\n');
for k = 1:N
    fprintf('n=%d -> f=%.2f kHz, Vn=%.3f V\n', ...
        k, (k*f0)/1e3, Vn(k));
end
%% Graficar señal en el tiempo
t = linspace(0, 2*T, 1000);
x = square(2*pi*f0*t, D*100); % Onda cuadrada con duty cycle
x(x<0) = 0; % Ajustar para que sea de 0 a V
x = V*x;

figure;
plot(t*1e6, x, 'LineWidth', 1.5);
xlabel('Tiempo [\mus]');
ylabel('Amplitud [V]');
title(sprintf('Onda cuadrada con Duty Cycle = %.1f %%', D*100));
grid on;

%% Graficar espectro de armónicos
figure;
stem(n*f0/1e3, Vn, 'filled');
xlabel('Frecuencia [kHz]');
ylabel('Magnitud [V]');
title('Espectro de los primeros 10 armónicos');
grid on;