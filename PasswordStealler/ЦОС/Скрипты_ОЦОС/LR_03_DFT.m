script
clc
clear
disp('% ЛР №3. ДИСКРЕТНОЕ ПРЕОБРАЗОВАНИЕ ФУРЬЕ')
disp('%')
disp('% Введите ИСХОДНЫЕ ДАННЫЕ');
DATA=0;
while DATA==0
N = input('N = ');             % ДЛИНА (ПЕРИОД) ПОСЛЕДОВАТЕЛЬНОСТИ
Fs = input('Fs = ');           % ЧАСТОТА ДИСКРЕТИЗАЦИИ
A1 = input('A1 = ');           % АМПЛИТУДЫ ДИСКРЕТНЫХ ГАРМОНИК
A2 = input('A2 = ');
f1 = input('f1 = ');           % ЧАСТОТЫ (Гц) ДИСКРЕТНЫХ ГАРМОНИК
f2 = input('f2 = ');
disp('% Проверьте ПРАВИЛЬНОСТЬ ввода ИСХОДНЫХ ДАННЫХ')
disp('% При ПРАВИЛЬНЫХ ИСХОДНЫХ ДАННЫХ введите 1')
disp('% При НЕПРАВИЛЬНЫХ ИСХОДНЫХ ДАННЫХ введите 0 и ПОВТОРИТЕ ввод')
DATA = input('--> ');
end
disp('%')
disp('% Для вывода ИСХОДНЫХ АМПЛИТУД и ЧАСТОТ ДИСКРЕТНЫХ ГАРМОНИК нажмите <ENTER>')
pause
disp('%')
disp(['      A1 = ' num2str(A1) '      A2 = ' num2str(A2)])
disp(['      f1 = ' num2str(f1) '      f2 = ' num2str(f2)])
disp('%')
disp('% Для продолжения нажмите <ENTER>')
pause
disp('%')
disp('% п.1. ВЫЧИСЛЕНИЕ АМПЛИТУДНОГО И ФАЗОВОГО СПЕКТРОВ ПЕРИОДИЧЕСКОЙ ПОСЛЕДОВАТЕЛЬНОСТИ')
disp('%')
disp('% Для вывода ГРАФИКОВ периодической последовательности нажмите <ENTER>')
pause
n = 0:(N-1);                 	 % ДИСКРЕТНОЕ НОРМИРОВАННОЕ ВРЕМЯ
k = 0:(N-1);                      % ДИСКРЕТНАЯ НОРМИРОВАННАЯ ЧАСТОТА
w1 = 2*pi*f1/Fs; w2 = 2*pi*f2/Fs;  % НОРМИРОВАННЫЕ ЧАСТОТЫ ДИСКРЕТНЫХ ГАРМОНИК (РАД)
x = A1*cos(w1*n+pi/4)+A2*cos(w2*n+pi/8);   % ПЕРИОДИЧЕСКАЯ ПОСЛЕДОВАТЕЛЬНОСТЬ
X = fft(x);                        % ДПФ ПЕРИОДИЧЕСКОЙ ПОСЛЕДОВАТЕЛЬНОСТИ
MOD = (2/N)*abs(X);                % АМПЛИТУДНЫЙ СПЕКТР ПЕРИОДИЧЕСКОЙ ПОСЛЕДОВАТЕЛЬНОСТИ
MOD(1) = (1/N)*abs(X(1));
PHASE = angle(X);                  % ФАЗОВЫЙ СПЕКТР ПЕРИОДИЧЕСКОЙ ПОСЛЕДОВАТЕЛЬНОСТИ
for i = 1:N
    if (abs(X(i)) < 1e-4)
       PHASE(i)=0;
    end
end
figure('Name','Периодическая последовательность','NumberTitle','off')
subplot(3,1,1), stem(n,x, 'MarkerSize',3,'Linewidth',2)
grid, xlabel('n')
ylabel('x(n)'), title(strcat(['Периодическая последовательность x(n)  N = ',num2str(N)]))
subplot(3,1,2), stem(n/Fs,x,'MarkerSize',3,'Linewidth',2)
grid, xlabel('nT')
ylabel('x(nT)'), title(strcat(['Периодическая последовательность x(nT)  N = ',num2str(N)]))
x = ifft(X);                     % ПЕРИОДИЧЕСКАЯ ПОСЛЕДОВАТЕЛЬНОСТЬ, ВЫЧИСЛЕННАЯ С ПОМОЩЬЮ ОДПФ
subplot(3,1,3), stem(n,x,'MarkerSize',3,'Linewidth',2)
grid, xlabel('n')
ylabel('x(n)'), title(strcat(['Периодическая последовательность x = ifft(X)  N = ',num2str(N)]))
disp('%')
disp('% Для вывода ГРАФИКОВ АМПЛИТУДНОГО СПЕКТРА периодической последовательности нажмите <ENTER>')
pause
figure('Name','Амплитудный спектр','NumberTitle', 'off')
subplot(2,1,1), stem(k,MOD,'MarkerSize',3,'Linewidth',2), grid
xlabel('k'), ylabel('1/N|X(k)|')
title(strcat(['Амплитудный спектр периодической последовательности N = ',num2str(N)]))
subplot(2,1,2), stem(k.*(Fs/N),MOD,'MarkerSize',3,'Linewidth',2),grid
xlabel('f (Hz)'), ylabel('1/N|X(f)|')
title(strcat(['Амплитудный спектр периодической последовательности N = ',num2str(N)]))
disp('%')
disp('% Для вывода ГРАФИКОВ ФАЗОВОГО СПЕКТРА периодической последовательности нажмите <ENTER>')
pause
figure('Name','Фазовый спектр','NumberTitle', 'off')
subplot(2,1,1), stem(k, PHASE,'MarkerSize',3,'Linewidth',2), grid
xlabel('k'), ylabel('arg{X(k)} (rad)')
title(strcat(['Фазовый спектр периодической последовательности N = ',num2str(N)]))
subplot(2,1,2), stem(k*(Fs/N),PHASE,'MarkerSize',3,'Linewidth',2)
grid, xlabel('f (Hz)'), ylabel('arg{X(f)} (rad)')
title(strcat(['Фазовый спектр периодической последовательности N = ',num2str(N)]))
disp('%')
disp('% Для продолжения нажмите <ENTER>')
pause
disp('%')
disp('% п.2. ВЫЧИСЛЕНИЕ ДПФ КОНЕЧНОЙ ПОСЛЕДОВАТЕЛЬНОСТИ')
disp('%')
disp('% Для вывода ГРАФИКОВ МОДУЛЯ ДПФ конечной последовательности и АМПЛИТУДНОГО СПЕКТРА')
disp('% периодической последовательности нажмите <ENTER>')
pause
MOD_K = abs(fft(x));        % МОДУЛЬ ДПФ КОНЕЧНОЙ ПОСЛЕДОВАТЕЛЬНОСТИ
figure('Name','Модуль ДПФ и амплитудный спектр', 'NumberTitle','off')
subplot(2,1,1), stem(k,MOD_K,'MarkerSize',3,'Linewidth',2), grid
xlabel('k'), ylabel('|X(k)|')
title('Модуль ДПФ конечной последовательности')
subplot(2,1,2), stem(k,MOD,'MarkerSize',3,'Linewidth',2), grid
xlabel('k'), ylabel('1/N |X(k)|')
title('Амплитудный спектр периодической последовательности')
disp('%')
disp('% Для продолжения нажмите <ENTER>')
pause
disp('%')
disp('% п.3. ВОССТАНОВЛЕНИЕ АНАЛОГОВОГО СИГНАЛА')
disp('%')
disp('% Для вывода ГРАФИКОВ ПОСЛЕДОВАТЕЛЬНОСТИ и МОДУЛЯ ее ДПФ,')
disp('% ВОССТАНОВЛЕННОГО АНАЛОГОВОГО СИГНАЛА и его СПЕКТРА')
disp('% и ИСХОДНОГО АНАЛОГОВОГО СИГНАЛА нажмите <ENTER>')
pause
Xa  = [X(N/2+1:N),X(1:N/2)]; % СПЕКТР АНАЛОГОВОГО СИГНАЛА (С ТОЧНОСТЬЮ ДО ПОСТОЯННОГО МНОЖИТЕЛЯ)
i = 1;                       % СЧЕТЧИК ЗНАЧЕНИЙ АНАЛОГОВОГО СИГНАЛА
T = 1/Fs;                      % ПЕРИОД ДИСКРЕТИЗАЦИИ
for t = 0:0.25*T:(N-1)*T     % ЗНАЧЕНИЯ НЕПРЕРЫВНОГО ВРЕМЕНИ
    s = 0;        
    for k = -N/2:N/2-1       % ДИСКРЕТНАЯ НОРМИРОВАННАЯ ЧАСТОТА
        s = s + Xa(k+N/2+1)*exp(1i*2*pi*k*t/(N*T)); % ВОССТАНОВЛЕНИЕ АНАЛОГОВОГО СИГНАЛА
    end
    xa(i) = (1/N).*s;        % ЗНАЧЕНИЯ ВОССТАНОВЛЕННОГО АНАЛОГОВОГО СИГНАЛА
    i = i+1;
end
t = 0:0.25*T:(N-1)*T;
xt = A1*cos(2*pi*f1*t+pi/4)+A2*cos(2*pi*f2*t+pi/8);    % ЗНАЧЕНИЯ ИСХОДНОГО АНАЛОГОВОГО СИГНАЛА
k = 0:N-1;                    % ДИСКРЕТНАЯ НОРМИРОВАННАЯ ЧАСТОТА
MODa = (2/N)*abs(Xa);         % АМПЛИТУДНЫЙ СПЕКТР ВОССТАНОВЛЕННОГО АНАЛОГОВОГО СИГНАЛА
MODa(1) = (1/N)*abs(Xa(1));
figure('Name','Исходная периодическая последовательность и её ДПФ, Восстановленный аналоговый сигнал и его спектр, Исходный аналоговый сигнал','NumberTitle', 'off')
subplot(3,2,1), stem(n,x,'MarkerSize',3), grid
xlabel('n'), ylabel('x(n)')
title(strcat(['Исходная периодическая последовательность  N = ',num2str(N)]))
subplot(3,2,2), stem(k,abs(X),'MarkerSize',3,'Linewidth',2), grid
xlabel('k'), ylabel('|X(k)|')
title(strcat(['ДПФ исходной периодической последовательности  N = ',num2str(N)]))
subplot(3,2,3), plot(t,real(xa)), grid, xlabel('t')
ylabel('x(t)'),title('Восстановленный аналоговый сигнал')
k = -N/2:N/2-1;
subplot(3,2,4), stem(k,MODa,'MarkerSize',3,'Linewidth',2), grid
xlabel('k'), ylabel('|Xa(k)|')
title('Амплитудный спектр восстановленного аналогового сигнала')
subplot(3,2,5), plot(t,xt), grid, xlabel('t')
ylabel('x(t)'), title('Исходный аналоговый сигнал')
disp('%')
disp('% Для продолжения нажмите <ENTER>')
pause
disp('%')
disp('% п.4. ВОССТАНОВЛЕНИЕ СПЕКТРАЛЬНОЙ ПЛОТНОСТИ КОНЕЧНОЙ ПОСЛЕДОВАТЕЛЬНОСТИ')
disp('%')
disp('% Для вывода ГРАФИКОВ ДПФ и СПЕКТРАЛЬНОЙ ПЛОТНОСТИ конечной ')
disp('% последовательности нажмите <ENTER>')
pause
L = 2*N;          % КОЛИЧЕСТВО ОТСЧЕТОВ СПЕКТРАЛЬНОЙ ПЛОТНОСТИ НА ПЕРИОДЕ
xz = [x zeros(1,(L-N))];      % ПОСЛЕДОВАТЕЛЬНОСТЬ, ДОПОЛНЕННАЯ НУЛЯМИ ДО ДЛИНЫ L
XZ = fft(xz);                 % ДПФ ПОСЛЕДОВАТЕЛЬНОСТИ, ДОПОЛНЕННОЙ НУЛЯМИ
k = 0:(N-1);                  % ДИСКРЕТНАЯ НОРМИРОВАННАЯ ЧАСТОТА
w = 0:2*pi/L:2*pi-2*pi/L;     % НОРМИРОВАННАЯ ЧАСТОТА
l = 0:(L-1);                  % ДИСКРЕТНАЯ НОРМИРОВАННАЯ ЧАСТОТА
figure('Name','ДПФ и спектральная плотность','NumberTitle', 'off')
subplot(2,1,1), stem(k,abs(X),'MarkerSize',3,'Linewidth',2)
grid, xlabel('k'), ylabel('|X(k)')
title(strcat(['Модуль ДПФ N = ',num2str(N)]))
subplot(2,1,2), plot(w,abs(XZ),'MarkerSize',3,'Linewidth',2)
grid, xlabel('w'), ylabel('|X(w)|')
title(strcat(['Модуль спектральной плотности L = ',num2str(L)]))
disp('%')
disp('% Для продолжения нажмите <ENTER>')
pause
disp('%')
disp('% п.5. УМЕНЬШЕНИЕ ПЕРИОДА ДИСКРЕТИЗАЦИИ ПО ЧАСТОТЕ ПРИ ВЫЧИСЛЕНИИ ДПФ')
disp('%')
disp('% Для вывода ГРАФИКОВ КОНЕЧНЫХ ПОСЛЕДОВАТЕЛЬНОСТЕЙ,')
disp('% ДПФ и СПЕКТРАЛЬНЫХ ПЛОТНОСТЕЙ нажмите <ENTER>')
pause
figure('Name','Последовательность конечной длины, ДПФ и модуль спектральной плотности','NumberTitle', 'off')
L = [N 2*N 4*N];
for i = 1:length(L)
    xz = [x zeros(1,(L(i)-N))];   % ПОСЛЕДОВАТЕЛЬНОСТЬ, ДОПОЛНЕННАЯ НУЛЯМИ ДО ДЛИНЫ L(i)
    XZ = fft(xz);
    Delta_f(i) = Fs/L(i);
    n = 0:length(xz)-1;           % ДИСКРЕТНОЕ НОРМИРОВАННОЕ ВРЕМЯ
    k = 0:length(XZ)-1;           % ДИСКРЕТНАЯ НОРМИРОВАННАЯ ЧАСТОТА
subplot(3,2,2*i-1), stem(n,xz,'MarkerSize',3), xlabel('n'), grid
title(strcat(['Последовательность конечной длины x(n) L = ',num2str(L(i))]))
subplot(3,2,2*i), plot(k,abs(XZ), 'r','MarkerSize',3, 'Linewidth',2), grid, hold on, stem(k,abs(XZ),':'), xlabel('k')
title(strcat(['ДПФ и модуль спектральной плотности L = ',num2str(L(i))]))
end
disp('%')
disp('% Для вывода ПЕРИОДОВ ДПФ и ПЕРИОДОВ ДИСКРЕТИЗАЦИИ ПО ЧАСТОТЕ нажмите <ENTER>')
pause
disp('%')
disp(['      L = [',num2str(L) ']'])
disp('%')
disp(['      Delta_f = [',num2str(Delta_f) ']'])
disp('%')
disp('% РАБОТА ЗАВЕРШЕНА')






























































































