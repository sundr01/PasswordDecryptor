DATA=0;
while DATA==0
disp('ЧАСТОТА ДИСКРЕТИЗАЦИИ')
f_d = input('f_d = ');
disp('АМПЛИТУДА ИМПУЛЬСА')
U = input('U = ');
disp('ПРОДОЛЖИТЕЛЬНОСТЬ ИМПУЛЬСА')
t_imp = input('t_imp = ');
disp('СКВАЖНОСТЬ ИМПУЛЬСА')
q = input('q = ');
disp('КОЛИЧЕСТВО ПОВТОРЕНИЙ')
count=input('count = ')
disp('% Проверьте ПРАВИЛЬНОСТЬ ввода ИСХОДНЫХ ДАННЫХ')
disp('% При НЕПРАВИЛЬНЫХ ИСХОДНЫХ ДАННЫХ введите 0 и ПОВТОРИТЕ ввод')
DATA = input('--> ');
end
t_imp_rect=t_imp/2;
n_s=round(f_d*q*t_imp_rect);
n_imp=round(f_d*t_imp_rect);
L=2*n_imp-1;
n=0:n_s-1;
n0=n_s-n_imp;
x3_1 = U*rectpuls(n-n0,2*n_imp);
x3_1(1:n0) = 0;
tr_s=conv(x3_1,x3_1);
s = repmat(tr_s,1,count);
n = 0:(length(s)-1);
figure;
subplot(1,1,1),stem(n, s,'Linewidth',2), xlabel('n'), grid
