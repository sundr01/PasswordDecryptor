script
clc
clear
disp('% кп ╧06. яхмрег онкнянбнцн аху-тхкэрпю лернднл ахкхмеимнцн Z-опенапюгнбюмхъ')
disp('%')
disp('% бБЕДХРЕ рпеанбюмхъ Й юву от')
DATA=0;
while DATA==0
Nb = input('Nv = ');         % мнлеп бюпхюмрю
Fs = input('Fs (цЖ) = ');         % вюярнрю дхяйперхгюжхх (цЖ)
fk1 = input('fstop1 (цЖ) = ');       % цпюмхвмюъ вюярнрю ог1 (цЖ)
ft1 = input('fpass1 (цЖ) = ');       % цпюмхвмюъ вюярнрю оо1 (цЖ)
ft2 = input('fpass2 (цЖ) = ');       % цпюмхвмюъ вюярнрю оо2 (цЖ)
fk2 = input('fstop2 (цЖ) = ');       % цпюмхвмюъ вюярнрю ог2 (цЖ)
rp = input('rpass (Да) = ');         % люйяхлюкэмн дносярхлне гюрсуюмхе б оо
rs = input('rstop (Да) = ');         % лхмхлюкэмн дносярхлне гюрсуюмхе б ог
disp('% оПНБЕПЭРЕ опюбхкэмнярэ ББНДЮ хяундмшу дюммшу')
disp('% оПХ опюбхкэмшу хяундмшу дюммшу ББЕДХРЕ 1')
disp('% оПХ меопюбхкэмшу хяундмшу дюммшу ББЕДХРЕ 0 Х онбрнпхре ББНД')
DATA = input('--> ');
end
disp('%')
disp('% О.1. яхмрег аху-тхкэрпнб аюррепбнпрю, веашьебю I х II пндю х гнкнрюпебю-йюсщпю')
disp('%')
disp('% дКЪ ЯХМРЕГЮ онкнянбшу аху-ТХКЭРПНБ МЮФЛХРЕ <ENTER>')
pause
ft = [ft1 ft2]; fk = [fk1 fk2];       % бейрнпш цпюмхвмшу вюярнр оо Х ог
WDp = ft/(Fs/2); WDs = fk/(Fs/2);     % бейрнпш цпюмхвмшу мнплхпнбюммшу вюярнр оо Х ог
[R1,WDn1] = buttord(WDp,WDs,rp,rs);   % онпъднй х вюярнрш япегю аху-тхкэрпю от аюррепбнпрю
[R2,WDn2] = cheb1ord(WDp,WDs,rp,rs);  % онпъднй х вюярнрш япегю аху-тхкэрпю от веашьебю I пндю
[R3,WDn3] = cheb2ord(WDp,WDs,rp,rs);  % онпъднй х вюярнрш япегю аху-тхкэрпю от веашьебю II пндю
[R4,WDn4] = ellipord(WDp,WDs,rp,rs);  % онпъднй х вюярнрш япегю аху-тхкэрпю от гнкнрюпебю-йюсщпю
[b1,a1] = butter(R1,WDn1);            % йнщттхжхемрш аху-тхкэрпю от аюррепбнпрю
[b2,a2] = cheby1(R2,rp,WDn2);         % йнщттхжхемрш аху-тхкэрпю от веашьебю I пндю
[b3,a3] = cheby2(R3,rs,WDn3);         % йнщттхжхемрш аху-тхкэрпю от веашьебю II пндю
[b4,a4] = ellip(R4,rp,rs,WDn4);       % йнщттхжхемрш аху-тхкэрпю от гнкнрюпебю-йюсщпю
disp('%')
disp('% дКЪ БШБНДЮ ОНПЪДЙНБ аху-ТХКЭРПНБ от МЮФЛХРЕ <ENTER>')
pause
disp('%')
disp(['   R1 = ' num2str(R1),'   R2 = ' num2str(R2),'   R3 = ' num2str(R3),'   R4 = ' num2str(R4)])
disp('%')
disp('% дКЪ ОПНДНКФЕМХЪ МЮФЛХРЕ <ENTER>')
pause
disp('%')
disp('% О.2. юмюкхг уюпюйрепхярхй онкнянбшу аху-тхкэрпнб')
disp('%')
disp('% дКЪ БШБНДЮ уюпюйрепхярхй аху-тхкэрпнб от (вершпе цпютхвеяйху нймю) МЮФЛХРЕ <ENTER>')
pause
M = 50; 
n = 0:(M-1);
f = 0:((Fs/2)/1000):Fs/2; 
figure('Name','от аху-ТХКЭРП аЮРРЕПБНПРЮ','NumberTitle', 'off')
h1 = impz(b1,a1,M);         % ху от аху-тхкэрпю аюррепбнпрю    
H1 = freqz(b1,a1,f,Fs);     % ву от аху-тхкэрпю аюррепбнпрю
MAG = abs(H1);              % юву от аху-тхкэрпю аюррепбнпрю
PHASE = phase(H1);          % тву от аху-тхкэрпю аюррепбнпрю
subplot(2,2,1), plot(f,MAG), xlabel('f (цЖ)')
title('юлокхрсдю'), grid, ylim([0 1.2])
subplot(2,2,2), zplane(b1,a1), title('Z-ОКНЯЙНЯРЭ'), grid
subplot(2,2,3), plot(f,PHASE), xlabel('f (цЖ)')
title('тюгю'), grid
subplot(2,2,4), stem(n,h1,'fill','MarkerSize',3)
xlabel('n'), title('хлоскэямюъ уюпюйрепхярхйю'), grid
figure('Name','от аху-ТХКЭРП вЕАШЬЕБЮ I ПНДЮ','NumberTitle', 'off')
h2 = impz(b2,a2,M);         % ху от аху-тхкэрпю веашьебю I пндю
H2 = freqz(b2,a2,f,Fs);     % ву от аху-тхкэрпю веашьебю I пндю
MAG = abs(H2);              % юву от аху-тхкэрпю веашьебю I пндю
PHASE = phase(H2);          % тву от аху-тхкэрпю веашьебю I пндю
subplot(2,2,1), plot(f,MAG), xlabel('f (цЖ)')
title('юлокхрсдю'), grid, ylim([0 1.2])
subplot(2,2,2), zplane(b2,a2), title('Z-ОКНЯЙНЯРЭ'), grid
subplot(2,2,3), plot(f,PHASE), xlabel('f (цЖ)')
title('тюгю'), grid
subplot(2,2,4), stem(n,h2,'fill','MarkerSize',3)
xlabel('n'), title('хлоскэямюъ уюпюйрепхярхйю'), grid
figure('Name','от аху-ТХКЭРП вЕАШЬЕБЮ II ПНДЮ','NumberTitle', 'off')
h3 = impz(b3,a3,M);         % ху от аху-тхкэрпю веашьебю II пндю
H3 = freqz(b3,a3,f,Fs);     % ву от аху-тхкэрпю веашьебю II пндю
MAG = abs(H3);              % юву от аху-тхкэрпю веашьебю II пндю
PHASE = phase(H3);          % тву от аху-тхкэрпю веашьебю II пндю
subplot(2,2,1), plot(f,MAG), xlabel('f (цЖ)')
title('юлокхрсдю'), grid, ylim([0 1.2])
subplot(2,2,2), zplane(b3,a3), title('Z-ОКНЯЙНЯРЭ'), grid
subplot(2,2,3), plot(f,PHASE), xlabel('f (цЖ)')
title('тюгю'), grid
subplot(2,2,4), stem(n,h3,'fill','MarkerSize',3)
xlabel('n'), title('хлоскэямюъ уюпюйрепхярхйю'), grid
figure('Name','от аху-ТХКЭРП гНКНРНПЕБЮ-йЮСЩПЮ','NumberTitle', 'off')
h4 = impz(b4,a4,M);         % ху от аху-тхкэрпю гнкнрюпебю-йюсщпю
H4 = freqz(b4,a4,f,Fs);     % ву от аху-тхкэрпю гнкнрюпебю-йюсщпю
MAG = abs(H4);              % юву от аху-тхкэрпю гнкнрюпебю-йюсщпю
PHASE = phase(H4);          % тву от аху-тхкэрпю гнкнрюпебю-йюсщпю
subplot(2,2,1), plot(f,MAG), xlabel('f (цЖ)')
title('юлокхрсдю'), grid, ylim([0 1.2])
subplot(2,2,2), zplane(b4,a4), title('Z-ОКНЯЙНЯРЭ'), grid
subplot(2,2,3), plot(f,PHASE), xlabel('f (цЖ)')
title('тюгю'), grid
subplot(2,2,4), stem(n,h4,'fill','MarkerSize',3)
xlabel('n'), title('хлоскэямюъ уюпюйрепхярхйю'), grid
disp('%')
disp('% дКЪ ОПНДНКФЕМХЪ МЮФЛХРЕ <ENTER>')
pause
disp('%')
disp('% О.3. яхмрег юто аюррепбнпрю, веашьебю I х II пндю х гнкнрюпебю-йюсщпю')
disp('%')
disp('% дКЪ БШБНДЮ ЦПЮМХВМШУ ВЮЯРНР юто от МЮФЛХРЕ <ENTER>')
pause
disp('%')
Ft = (Fs/pi)*tan(pi*ft/Fs); Fk = (Fs/pi)*tan(pi*fk/Fs); % бейрнпш цпюмхвмшу вюярнр оо Х ог юто
disp(['   Fk1 = ' num2str(Fk(1)),'   Ft1 = ' num2str(Ft(1)),'   Ft2 = ' num2str(Ft(2)),'   Fk2 = ' num2str(Fk(2))])
disp('%')
disp('% дКЪ ЯХМРЕГЮ юто от МЮФЛХРЕ <ENTER>')
pause
Wp = 2.*pi.*Ft; Ws = 2.*pi.*Fk;       % бейрнпш цпюмхвмшу йпсцнбшу вюярнр оо Х ог юто
[Ra1,Wn1] = buttord(Wp,Ws,rp,rs,'s'); % онпъднй х вюярнрш япегю юто от аюррепбнпрю
[Ra2,Wn2] = cheb1ord(Wp,Ws,rp,rs,'s');% онпъднй х вюярнрш япегю юто от веашьебю I пндю
[Ra3,Wn3] = cheb2ord(Wp,Ws,rp,rs,'s');% онпъднй х вюярнрш япегю юто от веашьебю II пндю
[Ra4,Wn4] = ellipord(Wp,Ws,rp,rs,'s');% онпъднй х вюярнрш япегю юто от гнкнрюпебю-йюсщпю
[bs1,as1] = butter(Ra1,Wn1,'s');      % йнщттхжхемрш юто от аюррепбнпрю
[bs2,as2] = cheby1(Ra2,rp,Wn2,'s');   % йнщттхжхемрш юто от веашьебю I пндю
[bs3,as3] = cheby2(Ra3,rs,Wn3,'s');   % йнщттхжхемрш юто от веашьебю II пндю
[bs4,as4] = ellip(Ra4,rp,rs,Wn4,'s'); % йнщттхжхемрш юто от гнкнрюпебю-йюсщпю
disp('%')
disp('% дКЪ БШБНДЮ ОНПЪДЙНБ юто от МЮФЛХРЕ <ENTER>')
pause
disp('%')
disp(['   Ra1 = ' num2str(Ra1),'   Ra2 = ' num2str(Ra2),'   Ra3 = ' num2str(Ra3),'   Ra4 = ' num2str(Ra4)])
disp('%')
disp('% дКЪ ОПНДНКФЕМХЪ МЮФЛХРЕ <ENTER>')
pause
disp('%')
disp('% О.4. бшбнд цпютхйнб юву юто аюррепбнпрю, веашьебю I х II пндю х гнкнрюпебю-йюсщпю')
disp('%')
disp('% дКЪ БШБНДЮ цпютхйнб юву юто МЮФЛХРЕ <ENTER>')
pause
f = 0:((Fs/2)/1000):Fs/2;           % яерйю вюярнр дкъ цпютхйю юву
W = 2.*pi.*f;
Ha1 = freqs(bs1,as1,W);             % ву юто аюррепбнпрю
Ha2 = freqs(bs2,as2,W);             % ву юто веашьебю I пндю
Ha3 = freqs(bs3,as3,W);             % ву юто веашьебю II пндю
Ha4 = freqs(bs4,as4,W);             % ву юто гнкнрюпебю-йюсщпю
figure('Name','юву онкнянбнцн тхкэрпю юто','NumberTitle', 'off')
subplot(2,2,1),plot(f,abs(Ha1)),xlabel('f(цЖ)'),grid,...
ylabel('юлокхрсдю'),title('юМЮКНЦНБШИ ТХКЭРП аЮРРЕПБНПРЮ'),ylim([0 1.2])
subplot(2,2,2),plot(f,abs(Ha2)),xlabel('f(цЖ)'),grid,...
ylabel('юлокхрсдю'),title('юМЮКНЦНБШИ ТХКЭРП вЕАШЬЕБЮ I'),ylim([0 1.2])
subplot(2,2,3),plot(f,abs(Ha3)),xlabel('f(цЖ)'),grid,...
ylabel('юлокхрсдю'),title('юМЮКНЦНБШИ ТХКЭРП вЕАШЬЕБЮ II'),ylim([0 1.2])
subplot(2,2,4),plot(f, abs(Ha4)),xlabel('f(цЖ)'),grid,...
ylabel('юлокхрсдю'),title('юМЮКНЦНБШИ ТХКЭРП  гНКНРНПЕБЮ-йЮСЩПЮ'),ylim([0 1.2])
disp('%')
disp('% яхмрег онкнянбнцн аху-тхкэрпю гюбепьем')
































