clc; clear; close all;

% Parámetros de la señal
A = 0.5;          % Amplitud
f = 20;           % Frecuencia [Hz]
offset = 0.5;     % Offset para evitar negativos
fs = 200;         % Frecuencia de muestreo (ejemplo)
t = 0:1/fs:0.1;   % Tiempo de simulación

% Señal
V = A*sin(2*pi*f*t) + offset;

% Muestra 3 en t = 10 ms
t3 = 0.01;                  
V3 = A*sin(2*pi*f*t3) + offset;

fprintf('Muestra 3 en t=10ms: %.3f V\n', V3);

% Método SAR con 3 bits
Vref = 1;       % Rango de 0 a 1V
Nbits = 3;
res = Vref / (2^Nbits);
value = V3;
bits = zeros(1, Nbits);

fprintf('\nProceso SAR:\n');
for k = 1:Nbits
    step = Vref / (2^k);
    if value >= step
        bits(k) = 1;
        value = value - step;
    else
        bits(k) = 0;
    end
    fprintf('b%d = %d, valor restante = %.3f\n', Nbits-k, bits(k), value);
end

% Mostrar código binario final
binCode = num2str(bits);
disp(['Código binario = ', binCode]);

% ---- GRAFICA ----
figure;
plot(t, V, 'b', 'LineWidth',1.5); hold on;
stem(t3, V3, 'r', 'LineWidth', 2, 'DisplayName','Muestra 3');
title('Señal y Muestra 3');
xlabel('Tiempo [s]');
ylabel('Voltaje [V]');
grid on;
legend('Señal','Muestra 3');
%%