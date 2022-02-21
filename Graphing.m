%% Load data
data_Pho = transpose(xlsread('Data_Pho.xlsx')); 
data_FL = transpose(xlsread('Data_fl.xlsx'));
xAxesFL = (1:36)*10+440;
xAxesPho = (1:56)*10+240;
FLP1 = reshape(data_FL(1,1:36*9),36,9).';
FLP2 = reshape(data_FL(1,326:685),36,10).';

PHOP1 = reshape(data_Pho(1,1:56*9),56,9).';
PHOP2 = reshape(data_Pho(1,506:1065),56,10).';
% plot(xAxesFL,data_FL(1,1:36))

%% Normalising
NFLP1 = zeros(9,36);
NFLP2 = zeros(10,36);
% NPHOP1 = zeros(9,56);
% NPHOP2 = zeros(10,56);
for i = 1:9
    NFLP1(i,:) = FLP1(i,:)./max(FLP1(i,:));
%     NPHOP1(i,:) = PHOP1(i,:)./max(PHOP1(i,:));
end

for i = 1:10
    NFLP2(i,:) = FLP2(i,:)./max(FLP2(i,:));
%     NPHOP2(i,:) = PHOP2(i,:)./max(PHOP2(i,:));
end
%% Graphing
% FL
figure(1)
title('Procedure 1 FL Spectra')
hold on
for i = 1:9
    plot(xAxesFL, NFLP1(i,:))
end

for n = 1:9
    legendname{n} = ['G0',num2str(n)];
end
legend(legendname);
ylabel('Normalised Emission')
xlabel('Wavelength (nm)')
hold off
grid on

%
figure(2)
title('Procedure 2 FL Spectra')
hold on
for i = 1:10
    plot(xAxesFL, NFLP2(i,:))
end

for n = 1:10
    if n < 10
        legendname{n} = ['H0',num2str(n)];
    else
        legendname{n} = ['H',num2str(n)];
    end
end
legend(legendname);
ylabel('Normalised Emission')
xlabel('Wavelength (nm)')
hold off
grid on

% PHO
figure(3)
hold on
title('Procedure 1 Pho Spectra')
for i = 1:9
    plot(xAxesPho, PHOP1(i,:))
end

for n = 1:9
    legendname{n} = ['G0',num2str(n)];
end
legend(legendname);
ylabel('Absorbance')
xlabel('Wavelength (nm)')
xlim([400 700])
hold off
grid on

%
figure(4)
title('Procedure 2 Pho Spectra')
hold on
for i = 1:9
    plot(xAxesPho, PHOP2(i,:))
end

for n = 1:10
    if n < 10
        legendname{n} = ['H0',num2str(n)];
    else
        legendname{n} = ['H',num2str(n)];
    end
end
legend(legendname);
ylabel('Absorbance')
xlabel('Wavelength (nm)')
xlim([400 700])
hold off
grid on

%% Estimating size

% Constants
h = 6.63*10^-34;    % Js
c = 3.00*10^8;      % ms^-1
me = 1.18*10^-31;   % kg
mh = 4.10*10^-31;   % kg
Eg = 2.79*10^-19;   % J

% Emission Wavelength
for i = 1:9
    WL(i) = 440+10*(find(FLP1(i,:) == max(FLP1(i,:))));
end
lambda = WL.*10^-9;
% Calculation
num = ((me^-1)+(mh^-1))*h^2;
den = 8*(((h*c)./lambda)-Eg);
r = sqrt(num./den);
sizes = (4/3)*pi.*r.^3;
figure(5)
plot(WL,sizes, '-s')
xlabel("Emission Wavelength (nm)")
ylabel('Spherical Volume (m^3)')
title('Size of Protocol 1 Quantum Dots')
%% Testing
