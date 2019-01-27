% Access the .xlsx file containing Dataset, select the sheet, select the
% Trial data. Since we know there are 1000 signal points, we can set a time
% axis and plot the values to visualize the data
close all
clear all
clc
num = xlsread('Filename','Sheet','Range');
t=1:length(num);
plot(t,num)
title('Title of Graph')
% To extract the Features of the Signal, we can use the following operations
% (1) MEAN ABSOLUTE VALUE/ INTEGRAL OF ABSOLUTE VALUE(IAV)
MAV = mean(num)
% (2) RMS value
%function out=myrms(num)
%N=length(num);
%out=sqrt(sum(num.^2)/N);
RMS = rms(num)
% (3) VARIANCE
VAR = var(num)
% (4) STANDARD DEVIATION
STD_DEV = std(num)
% (5) KURTOSIS
KURT = kurtosis(num)
% (6) SKEWNESS
SKEW = skewness(num)
% (7) WILLISON AMPLITUDE
% Set the threshold value
WAMP = emgwamp(num,0.01)
% (8) NUMBER OF TURNS
% Set the threshold value
TURNS = emgssc(num, 0.01)
% (9) ZERO CROSSING
% Set the threshold value
ZC = emgzc(num, 0.01)
% (10) WAVEFORM LENGTH
WL =emgwl(num)
% (11) MEAN FREQUENCY
MEAN_FREQ = meanfreq(num)
% (12) MEDIAN FREQUENCY
MED_FREQ = medfreq(num)
% (13) SIGNAL TO NOISE RATIO
SNR = snr(num)
% (14) MEAN ABSOLUTE DEVIATION
MEAN_AD = mad(num,0)
% (15) MEDIAN ABSOLUTE DEVIATION
MED_AD = mad(num,1)
% (16) SIMPLE SQUARE INTEGRAL
SSI = sum(num.^2)
% (17) AVERAGE AMPLITUDE CHANGE
ACC = acc(num)
% (18) DIFFERENCE ABSOLUTE STANDARD DEVIATION VALUE
DASDV = dasdv(num)
% (19) V-ORDER
V_ORD = vorder(num,3)
% (20) MYOPULSE PERCENTAGE RATE
MYOP = myop(num, 0.4)
% Set the threshold value
% (21) TEMPORAL MOMENT 3
TM3 = temp(num,3)
% (22) TEMPORAL MOMENT 5
TM5 = temp(num,5)
% (23) AUTO-REGRESSION COEFFICIENTS
% Set the order required
pxx2 = pburg(num,2,1)
pxx3 = pburg(num,3,1)
pxx5 = pburg(num,5,1)
pxx7 = pburg(num,7,1)
pxx10= pburg(num,10,1)

% The following operations write the solutions directly to the xlsx file.
xlswrite('Filename',MAV,'Sheet','Range')
xlswrite('Filename',RMS,'Sheet','Range')
xlswrite('Filename',VAR,'Sheet','Range')
xlswrite('Filename',STD_DEV,'Sheet','Range')
xlswrite('Filename',KURT,'Sheet','Range')
xlswrite('Filename',SKEW,'Sheet','Range')
xlswrite('Filename',WAMP,'Sheet','Range')
xlswrite('Filename',TURNS,'Sheet','Range')
xlswrite('Filename',ZC,'Sheet','Range')
xlswrite('Filename',WL,'Sheet','Range')
xlswrite('Filename',MEAN_FREQ,'Sheet','Range')
xlswrite('Filename',MED_FREQ,'Sheet','Range')
xlswrite('Filename',SNR,'Sheet','Range')
xlswrite('Filename',MEAN_AD,'Sheet','Range')
xlswrite('Filename',MED_AD,'Sheet','Range')
xlswrite('Filename',SSI,'Sheet','Range')
xlswrite('Filename',ACC,'Sheet','Range')
xlswrite('Filename',DASDV,'Sheet','Range')
xlswrite('Filename',V_ORD,'Sheet','Range')
xlswrite('Filename',MYOP,'Sheet','Range')
xlswrite('Filename',TM3,'Sheet','Range')
xlswrite('Filename',TM5,'Sheet','Range')
xlswrite('Filename',pxx2,'Sheet','Range')
xlswrite('Filename',pxx3,'Sheet','Range')
xlswrite('Filename',pxx5,'Sheet','Range')
xlswrite('Filename',pxx7,'Sheet','Range')
xlswrite('Filename',pxx10,'Sheet','Range') 

%Power Spectral Density and Frequency
%[Pxx,F] = pwelch(num)
% Function for Mean Absolute Value
function out=emgmav(x)
N=length(x);
out=sum(abs(x))/N;
end
% Function for Willisons Amplitude
function wamp=emgwamp(x,th) %willison threshold
wamp=0;
N=length(x);
for i=1:N-1
    if abs(x(i)-x(i+1))>th
        wamp=wamp+1;
    end
end
end
% Function for Number of Turns
function ssc=emgssc(x,th) % th: noise threshold
N=length(x);
ssc=0;
for i=2:N-1
    if ((x(i)>x(i-1) && x(i)>x(i+1))||(x(i)<x(i-1) && x(i)<x(i+1))) && (abs(x(i)-x(i+1))>th && abs(x(i)-x(i-1))>th)
        ssc=ssc+1;
    else
        ssc=ssc+0;
    end
end
end
% Function for Zero Crossing
function zc=emgzc(x,th) %th=noise threshold
N=length(x);
zc=0;
for i=1:N-1
    if x(i)*x(i+1)<0 & abs(x(i)-x(i+1))>th
        zc=zc+1;
    end
end
end
% Function for Waveform Length
function out=emgwl(x)
out=0;
for i=2:length(x)
    out=out+abs(x(i)-x(i-1));
end
end
% Function for Average Amplitude Change
function out=acc(x) 
out=0;
N=length(x);
for i=1:N-1
    out = sum(abs(x(i)-x(i+1)))/N;
    end
end
%Difference Absolute Standard Deviation Value (DASDV)
function out=dasdv(x) 
out=0;
N=length(x);
for i=1:N-1
    out = sqrt(sum(square(abs(x(i)-x(i+1))))/N-1);
    end
end
% Function for V-order
function out=vorder(x,v) 
out=0;
N=length(x);
for i=1:N-1
    out1 = (sum(x.^v));
end
    out = (out1/N)^(1/v);
end
% Function for Myopulse Percentage Rate
function out=myop(x,th) % threshold
out=0;
N=length(x);
for i=1:N-1
    if abs(x(i))>th
        out=out+1;
    end
end
end
% Function for temporal moments
function out=temp(x,t)
out = 0;
N=length(x);
out=(sum(x.^t)/N);
end
