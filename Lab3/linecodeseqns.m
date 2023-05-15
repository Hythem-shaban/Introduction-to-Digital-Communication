clear
clc

Tb = 1;
f = 0:0.001:3;
A = 1;

UP_NRZ_PSD = (A^2 * Tb/4) .* sinc(f * Tb).^2 + ((A^2) / 4) * (f==0);
UP_RZ_PSD = (A^2 * Tb/16) .* (sinc(f * Tb/2)).^2 + (A^2 / 16)*(f==0) + (A^2 / 16)*(f==Tb); 
P_NRZ_PSD = (A^2 * Tb) .* (sinc(f * Tb)).^2 ;
P_RZ_PSD = (A^2 * Tb/4) .* (sinc(f * Tb/2)).^2 ;
BP_NRZ_PSD = (A^2 * Tb) .* sinc(f * Tb).^2 .* sin(pi * f * Tb).^2;
BP_RZ_PSD = (A^2 * Tb/4) .* sinc(f * Tb/2).^2 .* sin(pi * f * Tb).^2;
Manchester_PSD = (A^2 * Tb) .* sinc(f * Tb/2).^2 .* sin(pi * f * Tb/2).^2;


% Plot the PSD
figure
subplot(7,1,1)
plot(f, (UP_NRZ_PSD),'LineWidth', 2);
xlabel('Frequency');
title('Unipolar NRZ PSD');

subplot(7,1,2)
plot(f, (UP_RZ_PSD),'LineWidth', 2);
xlabel('Frequency');
title('Unipolar RZ PSD');

subplot(7,1,3)
plot(f, (P_NRZ_PSD),'LineWidth', 2);
xlabel('Frequency');
ylabel('Power/frequency (dB/Hz)');
title('Pplar NRZ PSD');

subplot(7,1,4)
plot(f, (P_RZ_PSD),'LineWidth', 2);
xlabel('Frequency');
title('Polar RZ PSD');

subplot(7,1,5)
plot(f, (BP_NRZ_PSD),'LineWidth', 2);
xlabel('Frequency');
title('Bipolar NRZ PSD');

subplot(7,1,6)
plot(f, (BP_RZ_PSD),'LineWidth', 2);
xlabel('Frequency');
title('Bipolar RZ PSD');

subplot(7,1,7)
plot(f, (Manchester_PSD),'LineWidth', 2);
xlabel('Frequency');
title('Manchester PSD');

