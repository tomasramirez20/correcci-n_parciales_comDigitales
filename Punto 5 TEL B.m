PUNTO 5 TEL B
clc; clear; close all;

% Parámetros
A = 1;
B = 0.5;
C = 1.2;
f = 1000;        % Hz
DC = 2.5;        % Offset de 2.5 V
Ts = 100e-6;     % 100 us
N = 10;          % número de muestras

% Vectores de muestra y tiempo
n = 0:N-1;           % índices de muestras (0 a 9)
t = n*Ts;            % tiempo correspondiente

% Señal V(t) con offset
V = A*sin(2*pi*f*t) + B*sin(2*pi*2*f*t) + C*sin(2*pi*3*f*t) + DC;

% Mostrar tabla en consola
fprintf('Muestra\tTiempo [s]\tV(t)\n');
for i = 1:N
    fprintf('%d\t%.6f\t%.4f\n', i, t(i), V(i));
end

figure;
stem(n+1, V, 'filled','LineWidth',1.5);
xlabel('Muestra n');
ylabel('V(t) [V]');
title('Muestras de la señal V(t) con offset de 2.5V');
grid on;