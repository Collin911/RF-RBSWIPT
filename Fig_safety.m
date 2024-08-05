d_BS = 0.5;
powerRad = [];
Ds = 1:0.2:5;
for D = Ds
    filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1f.mat',D,0);
    load(filename);
    [OB_M_phase, OB_M_power, OB_B_phase, OB_B_power] = ...
        Invasion(PowerFinalDistr1, PhaseFinalDistr1, Positions1, d_BS, lambda_t, lambda_r, Gt);
    pow = sum(OB_B_power) + sum(OB_M_power);
    powerRad = [powerRad pow];
end
powerRad = powerRad ./ (0.25*0.25);

clear plot
figure
set(gcf, 'unit', 'inch', 'position', [3 3 7 4])

plot(Ds, powerRad, 'LineStyle',':','Marker', '^','MarkerSize',5,'LineWidth',2, 'color', [231 76 60]./255);
axis on
box on
grid on
xlim([1 5]);

set(gca,'position',[0.089, 0.11, 0.899, 0.87])
% legend('Beamforming', ...
%     'RBS, ideal', 'RBS, noisy', ...
%     ...%'$\alpha = 2.5\%$, down', '$\alpha = 2.5\%$, up', ...
%     ...% '$\alpha = 3.5\%$, down, ideal', '$\alpha = 3.5\%$, down, noisy', ...
%     ...% '$\alpha = 3.5\%$, up, ideal', '$\alpha = 3.5\%$, up, noisy', ...
%     ...% '$\alpha = 5.0\%$, down, ideal', '$\alpha = 5.0\%$, down, noisy', ...
%     ...% '$\alpha = 5.0\%$, up, ideal', '$\alpha = 5.0\%$, up, noisy', ...
%     'interpreter', 'latex', 'FontName', 'Times New Roman', ...
%     'FontSize', 16, 'Location', 'Southwest')

xlabel('Distance($\rm m$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Peak Incident Power Density ($\rm W/m^2$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
