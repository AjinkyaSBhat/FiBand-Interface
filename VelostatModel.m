%Numerical Solution for Velostat Resistance-Pressure equations
%%Copyright Ajinkya Bhat 2017
clc
clear all
close all

%Init Constants
R0=1; %nominal
E=12*10^6; %Approx 1700 PSI
C1=E/6;
n=500;
sigma=linspace(1,20000,n); %Pascals

%% Stretch Pressure Equation
% 2*C1*(lam^2-lam^-4)-sigma;

for i=1:length(sigma)
    f =@(L) 2*C1*(L.^2-L.^-4)-sigma(i) ;
    Lam_solution(i)=fzero(f,10);
end
%% Resistance Stretch Equation
R=R0.*(2.-Lam_solution).*exp(-800*(Lam_solution-1));


%% Plotting
plot(sigma/1000,R)
grid on
title('Resistance-Pressure relationship for Velostat') 
xlabel('Pressure (kPa)')
ylabel('Resitance ( \Omega)')

%% Linear approximation fit for Low Pressure range
[fitresult, gof] = createFit(sigma(1:n/10), R(1:n/10))
title('Linear approximation at low to moderate pressures') 
xlabel('Pressure (Pa)')
ylabel('Resitance ( \Omega)')


