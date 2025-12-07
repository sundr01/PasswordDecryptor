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
% Цикл для расчёта выхода фильтра
for i = 1:N
   sum = 0;
   for k = nh
       if (i - k) > 0 
           sum = sum + b(k + 1) * x(i - k);
       end
   end
   y(i) = sum;
end
subplot(4,1,4), stem(n, y, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('n'), ylabel('y(n)'),
title('Реакция фильтра на сигнал x(n)');
disp('% Для вывода ГРАФИКОВ нажмите <ENTER>');
