script
clc
clear
disp('% кп ╧6. яхмрег аху-тхкэрпю тбв лернднл ахкхмеимнцн Z-опенапюгнбюмхъ')
disp('%')
disp('% бБЕДХРЕ рпеанбюмхъ Й юву тбв')
DATA=0;
while DATA==0
Nb = input('Nv = ');         % мнлеп бюпхюмрю
Fs = input('Fs (цЖ) = ');         % вюярнрю дхяйперхгюжхх (цЖ)
fk = input('fstop (цЖ) = ');         % цпюмхвмюъ вюярнрю ог (цЖ)
ft = input('fpass (цЖ) = ');         % цпюмхвмюъ вюярнрю оо (цЖ)
rs = input('rstop (Да) = ');         % лхмхлюкэмн дносярхлне гюрсуюмхе б ог
rp = input('rpass (Да) = ');         % люйяхлюкэмн дносярхлне гюрсуюмхе б оо
disp('% оПНБЕПЭРЕ опюбхкэмнярэ ББНДЮ хяундмшу дюммшу')
disp('% оПХ опюбхкэмшу хяундмшу дюммшу ББЕДХРЕ 1')
disp('% оПХ меопюбхкэмшу хяундмшу дюммшу ББЕДХРЕ 0 Х онбрнпхре ББНД')
DATA = input('--> ');
end
disp('%')
disp('% О.1. яхмрег аху-тхкэрпнб аюррепбнпрю, веашьебю I х II пндю х гнкнрюпебю-йюсщпю')
disp('%')
disp('% дКЪ ЯХМРЕГЮ аху-ТХКЭРПНБ тбв МЮФЛХРЕ <ENTER>')
pause
WDp = ft/(Fs/2); WDs = fk/(Fs/2);    % цпюмхвмше мнплхпнбюммше вюярнрш оо Х ог
[R1,WDn1] = buttord(WDp,WDs,rp,rs);  % онпъднй х вюярнрю япегю аху-тхкэрпю тбв аюррепбнпрю
[R2,WDn2] = cheb1ord(WDp,WDs,rp,rs); % онпъднй х вюярнрю япегю аху-тхкэрпю тбв веашьебю I пндю
[R3,WDn3] = cheb2ord(WDp,WDs,rp,rs); % онпъднй х вюярнрю япегю аху-тхкэрпю тбв веашьебю веашьебю II пндю
[R4,WDn4] = ellipord(WDp,WDs,rp,rs); % онпъднй х вюярнрю япегю аху-тхкэрпю тбв гнкнрюпебю-йюсщпю
[b1,a1] = butter(R1,WDn1,'high');    % йнщттхжхемрш аху-тхкэрпю тбв аюррепбнпрю
[b2,a2] = cheby1(R2,rp,WDn2,'high'); % йнщттхжхемрш аху-тхкэрпю тбв веашьебю I пндю
[b3,a3] = cheby2(R3,rs,WDn3,'high'); % йнщттхжхемрш аху-тхкэрпю тбв веашьебю II пндю
[b4,a4] = cheby2(R4,rs,WDn4,'high'); % йнщттхжхемрш аху-тхкэрпю тбв веашьебю гнкнрюпебю-йюсщпю
disp('%')
disp('% дКЪ БШБНДЮ ОНПЪДЙНБ аху-ТХКЭРПНБ тбв МЮФЛХРЕ <ENTER>')
pause
disp('%')
disp(['   R1 = ' num2str(R1),'   R2 = ' num2str(R2),'   R3 = ' num2str(R3),'   R4 = ' num2str(R4)])
disp('%')
disp('% дКЪ ОПНДНКФЕМХЪ МЮФЛХРЕ <ENTER>')
pause
disp('%')
disp('% О.2. юмюкхг уюпюйрепхярхй аху-тхкэрпнб тбв')
disp('%')
disp('% дКЪ БШБНДЮ уюпюйрепхярхй аху-тхкэрпнб тбв (вершпе цпютхвеяйху нймю) МЮФЛХРЕ <ENTER>')
pause
M = 50; 
n = 0:(M-1);
f = 0:((Fs/2)/1000):Fs/2; 
figure('Name','тбв аху-ТХКЭРП аЮРРЕПБНПРЮ','NumberTitle', 'off')
h1 = impz(b1,a1,M);         % ху аху-тхкэрпю тбв аюррепбнпрю    
H1 = freqz(b1,a1,f,Fs);     % ву аху-тхкэрпю тбв аюррепбнпрю
MAG = abs(H1);              % юву аху-тхкэрпю тбв аюррепбнпрю
PHASE = phase(H1);          % тву аху-тхкэрпю тбв аюррепбнпрю
subplot(2,2,1), plot(f,MAG), xlabel('f (цЖ)')
title('юлокхрсдю'), grid, ylim([0 1.2])
subplot(2,2,2), zplane(b1,a1), title('Z-ОКНЯЙНЯРЭ'), grid
subplot(2,2,3), plot(f,PHASE), xlabel('f (цЖ)')
title('тюгю'), grid
subplot(2,2,4), stem(n,h1,'fill','MarkerSize',3)
xlabel('n'), title('хлоскэямюъ уюпюйрепхярхйю'), grid
figure('Name','тбв аху-ТХКЭРП вЕАШЬЕБЮ I ПНДЮ','NumberTitle', 'off')
h2 = impz(b2,a2,M);         % ху аху-тхкэрпю тбв веашьебю I пндю
H2 = freqz(b2,a2,f,Fs);     % ву аху-тхкэрпю тбв веашьебю I пндю
MAG = abs(H2);              % юву аху-тхкэрпю тбв веашьебю I пндю
PHASE = phase(H2);          % тву аху-тхкэрпю тбв веашьебю I пндю
subplot(2,2,1), plot(f,MAG), xlabel('f (цЖ)')
title('юлокхрсдю'), grid, ylim([0 1.2])
subplot(2,2,2), zplane(b2,a2), title('Z-ОКНЯЙНЯРЭ'), grid
subplot(2,2,3), plot(f,PHASE), xlabel('f (цЖ)')
title('тюгю'), grid
subplot(2,2,4), stem(n,h2,'fill','MarkerSize',3)
xlabel('n'), title('хлоскэямюъ уюпюйрепхярхйю'), grid
figure('Name','тбв аху-ТХКЭРП вЕАШЬЕБЮ II ПНДЮ','NumberTitle', 'off')
h3 = impz(b3,a3,M);         % ху аху-тхкэрпю тбв веашьебю II пндю
H3 = freqz(b3,a3,f,Fs);     % ву аху-тхкэрпю тбв веашьебю II пндю
MAG = abs(H3);              % юву аху-тхкэрпю тбв веашьебю II пндю
PHASE = phase(H3);          % тву аху-тхкэрпю тбв веашьебю II пндю
subplot(2,2,1), plot(f,MAG), xlabel('f (цЖ)')
title('юлокхрсдю'), grid, ylim([0 1.2])
subplot(2,2,2), zplane(b3,a3), title('Z-ОКНЯЙНЯРЭ'), grid
subplot(2,2,3), plot(f,PHASE), xlabel('f (цЖ)')
title('тюгю'), grid
subplot(2,2,4), stem(n,h3,'fill','MarkerSize',3)
xlabel('n'), title('хлоскэямюъ уюпюйрепхярхйю'), grid
figure('Name','тбв аху-ТХКЭРП гНКНРНПЕБЮ-йЮСЩПЮ','NumberTitle', 'off')
h4 = impz(b4,a4,M);         % ху аху-тхкэрпю тмв гнкнрюпебю-йюсщпю
H4 = freqz(b4,a4,f,Fs);     % ву аху-тхкэрпю тмв гнкнрюпебю-йюсщпю
MAG = abs(H4);              % юву аху-тхкэрпю тмв гнкнрюпебю-йюсщпю
PHASE = phase(H4);          % тву аху-тхкэрпю тмв гнкнрюпебю-йюсщпю
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
disp('% О.3. яхмрег юто аюррепбнпрю, веашьебю I х II  пндю х гнкнрюпебю-йюсщпю')
disp('%')
disp('% дКЪ БШБНДЮ ЦПЮМХВМШУ ВЮЯРНР юто тбв МЮФЛХРЕ <ENTER>')
pause
disp('%')
Ft = (Fs/pi)*tan(pi*ft/Fs); Fk = (Fs/pi)*tan(pi*fk/Fs); % цпюмхвмше вюярнрш оо Х ог юто
disp(['   Fstop = ' num2str(Fk),'   Fpass = ' num2str(Ft)])
disp('%')
disp('% дКЪ ЯХМРЕГЮ юто тбв МЮФЛХРЕ <ENTER>')
pause
Wp = 2.*pi.*Ft; Ws = 2.*pi.*Fk;   % цпюмхвмше йпсцнбше вюярнрш оо Х ог юто
[Ra1,Wn1] = buttord(Wp,Ws,rp,rs,'s');   % онпъднй х вюярнрю япегю юто тбв аюррепбнпрю
[Ra2,Wn2] = cheb1ord(Wp,Ws,rp,rs,'s');  % онпъднй х вюярнрю япегю юто тбв веашьебю I пндю
[Ra3,Wn3] = cheb2ord(Wp,Ws,rp,rs,'s');  % онпъднй х вюярнрю япегю юто тбв веашьебю II пндю
[Ra4,Wn4] = ellipord(Wp,Ws,rp,rs,'s');  % онпъднй х вюярнрю япегю юто тбв гнкнрюпебю-йюсщпю
[bs1,as1] = butter(Ra1,Wn1,'high','s');      % йнщттхжхемрш юто тбв аюррепбнпрю
[bs2,as2] = cheby1(Ra2,rp,Wn2,'high','s');   % йнщттхжхемрш юто тбв веашьебю I пндю
[bs3,as3] = cheby2(Ra3,rs,Wn3,'high','s');   % йнщттхжхемрш юто тбв веашьебю II пндю
[bs4,as4] = ellip(Ra4,rp,rs,Wn4,'high','s'); % йнщттхжхемрш юто тбв веашьебю гнкнрюпебю-йюсщпю
disp('%')
disp('% дКЪ БШБНДЮ ОНПЪДЙНБ юто тбв МЮФЛХРЕ <ENTER>')
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
figure('Name','юву тбв юто','NumberTitle', 'off')
subplot(2,2,1),plot(f,abs(Ha1)),xlabel('f(цЖ)'),grid,...
ylabel('юлокхрсдю'),title('юМЮКНЦНБШИ ТХКЭРП аЮРРЕПБНПРЮ'),ylim([0 1.2])
subplot(2,2,2),plot(f,abs(Ha2)),xlabel('f(цЖ)'),grid,...
ylabel('юлокхрсдю'),title('юМЮКНЦНБШИ ТХКЭРП вЕАШЬЕБЮ I'),ylim([0 1.2])
subplot(2,2,3),plot(f,abs(Ha3)),xlabel('f(цЖ)'),grid,...
ylabel('юлокхрсдю'),title('юМЮКНЦНБШИ ТХКЭРП вЕАШЬЕБЮ II'),ylim([0 1.2])
subplot(2,2,4),plot(f, abs(Ha4)),xlabel('f(цЖ)'),grid,...
ylabel('юлокхрсдю'),title('юМЮКНЦНБШИ ТХКЭРП  гНКНРНПЕБЮ-йЮСЩПЮ'),ylim([0 1.2])
disp('%')
disp('% яхмрег аху-тхкэрпю тбв гюбепьем')


































