N = 128;    % ДЛИТЕЛЬНОСТЬ СИГНАЛА
b = [0.1, 0.2, 0.3, 0.4, 0.3, 0.2, 0.1]; % ВЕКТОР КОЭФФИЦИЕНТОВ КИХ-ФИЛЬТРА
Fs = 15000;  % ЧАСТОТА ДИСКРЕТИЗАЦИИ
A1 = 2;     % АМПЛИТУДЫ ДИСКРЕТНЫХ ГАРМОНИК
A2 = 3;
f1 = 1875;   % ЧАСТОТЫ (Гц) ДИСКРЕТНЫХ ГАРМОНИК
f2 = 3750;
disp('% Для вывода ГРАФИКОВ нажмите <ENTER>')
pause;
nh = 0:length(b) - 1;
n = 0:N-1;                        % ДИСКРЕТНОЕ НОРМИРОВАННОЕ ВРЕМЯ
Fn = n * 1/Fs;                    % ДИСКРЕТНОЕ НЕ НОРМИРОВАННОЕ ВРЕМЯ
w1 = 2*pi*f1/Fs; w2 = 2*pi*f2/Fs; % НОРМИРОВАННЫЕ ЧАСТОТЫ ДИСКРЕТНЫХ ГАРМОНИК (РАД)
x1 = A1*cos(w1*n+pi/4);
x2 = A2*cos(w2*n+pi/8);
x = x1 + x2;                        % ПЕРИОДИЧЕСКАЯ ПОСЛЕДОВАТЕЛЬНОСТЬ
nf = n * Fs/N;
X = abs(fft(x));
X = 2/N * X;
Y = abs(fft(y));
Y = 2/N * Y;
figure('Name','Спектры воздействия и реакции КИХ-фильтра','NumberTitle', 'off')
subplot(4,1,1), stem(n, X, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('n'), ylabel('X(n)'),
title('Амплитудный спектр пос-ти x(n)');
subplot(4,1,2), stem(nf, X, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('nf'), ylabel('X(nf)'),
title('Амплитудный спектр пос-ти X(nf)');
subplot(4,1,3), stem(nf, Y, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('n'), ylabel('Y(n)'),
title('Амплитудный спектр реакции КИХ-фильтра');
subplot(4,1,4), stem(nf, Y, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('nf'), ylabel('Y(nf)'),
title('Амплитудный спектр реакции КИХ-фильтра');
