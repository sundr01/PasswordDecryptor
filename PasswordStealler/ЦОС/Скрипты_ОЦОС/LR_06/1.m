N = 100;    % ДЛИТЕЛЬНОСТЬ СИГНАЛА
b = [-0.0006, -0.0006]; % ВЕКТОР КОЭФФИЦИЕНТОВ КИХ-ФИЛЬТРА
Fs = 6100;  % ЧАСТОТА ДИСКРЕТИЗАЦИИ
A1 = 5;     % АМПЛИТУДЫ ДИСКРЕТНЫХ ГАРМОНИК
A2 = 10;
f1 = 305;   % ЧАСТОТЫ (Гц) ДИСКРЕТНЫХ ГАРМОНИК
f2 = 1220;

disp('% Для вывода ГРАФИКОВ нажмите <ENTER>')
pause;

nh = 0:length(b) - 1;
n = 0:N-1;                            % ДИСКРЕТНОЕ НОРМИРОВАННОЕ ВРЕМЯ
Fn = n * 1/Fs;                          % ДИСКРЕТНОЕ НЕ НОРМИРОАПННОЕ ВРЕМЯ
w1 = 2*pi*f1/Fs; w2 = 2*pi*f2/Fs;   % НОРМИРОВАННЫЕ ЧАСТОТЫ ДИСКРЕТНЫХ ГАРМОНИК (РАД)
x1 = A1*cos(w1*n+pi/4);
x2 = A2*cos(w2*n+pi/8);
x = x1 + x2;                        % ПЕРИОДИЧЕСКАЯ ПОСЛЕДОВАТЕЛЬНОСТЬ

figure('Name','Реакция КИХ-фильтра','NumberTitle', 'off')
subplot(4,1,1), stem(n, x1, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('n'), ylabel('x1(n)'), 
title(['Гармонический сигнал x1(n) c f1=',num2str(f1)]);

subplot(4,1,2), stem(n, x2, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('n'), ylabel('x2(n)'),
title(['Гармонический сигнал x2(n) c f2=',num2str(f2)]);

subplot(4,1,3), stem(n, x, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('n'), ylabel('x(n)');
title('Гармонический сигнал x1(n) + x2(n)');

x_copy = repmat(x, 1, 2);
y = zeros(1, N);
for i = 1:N
    sum = 0;
    for k = nh
        xk = x_copy(N - k:N);
        bk = xk(i) * b(k + 1);
        sum = sum + bk;
    end
     y(i) = sum;
end
subplot(4,1,4), stem(n, y, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('n'), ylabel('y(n)'),
title('Реакция фильтра на сигнал x(n)');

disp('% Для вывода ГРАФИКОВ нажмите <ENTER>')
pause;

nf = n * Fs/N;
X = abs(fft(x));
X = 2/N * X;
X(1) = 1/N * X(1);

Y = abs(fft(y));
Y = 2/N * Y;
Y(1) = 1/N * Y(1);

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
