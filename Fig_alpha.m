%% power vs distance
clear all

power_down_t = [];
power_down_r = [];
power_up_t = [];
power_up_r = [];
iter = [];

R_x = 0;
D = 3;
Rpows = 0.95:0.005:0.99;
Rs = 1-0.006-Rpows;
Rs = [0.002:0.001:0.01 0.014:0.005:0.044];
Rs = [0.002:0.001:0.004];
Rpows = 1-0.006-Rs;

for returnRatio = Rs

    filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1freturn%.1f_noisy.mat',D,R_x, returnRatio*100);
    load(filename)
    PBt = mean([PBt1 PBt2 PBt3]);
    PMr = mean([PMr1 PMr2 PMr3]);
    eta = mean([eta_down1 eta_down2 eta_down3]);
    PBr = mean([PBr1 PBr2 PBr3]);
    PMt = mean([PMt1 PMt2 PMt3]);
    itr = mean([iterTimes1 iterTimes2 iterTimes3]);
    power_down_t = [power_down_t PBt];
    power_down_r = [power_down_r PMr];
    power_up_t = [power_up_t PMt];
    power_up_r = [power_up_r PBr];
    iter = [iter itr];
end

clear plot
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 3.5 7 4])

yyaxis left

% plot(Rs.*100, pow2db(power_up_t)+30, 'LineStyle',':','Marker', '^','MarkerSize',2,'LineWidth',2, 'color', [231 76 60]./255);
plot(Rs.*100, pow2db(power_up_r.*10.*rComm)+30, 'LineStyle','-','Marker', '^','MarkerSize',2,'LineWidth',2, 'color', [231 76 60]./255);
% plot(Rs.*100, pow2db(power_down_t)+30, 'LineStyle',':','Marker', 'v','MarkerSize',2,'LineWidth',2, 'color', [0 0.4470 0.7410]);
plot(Rs.*100, pow2db(power_down_r.*Rpows)+30, 'LineStyle','-','Marker', 'v','MarkerSize',2,'LineWidth',2, 'color', [0 0.4470 0.7410]);
plot(Rs.*100, pow2db(power_down_r.*rComm)+30, 'LineStyle','-','Marker', '^','MarkerSize',2,'LineWidth',2, 'color', [231 76 60]./255);

axis on
box on
grid on
%xlim([1 5]);

set(gca,'position',[0.085, 0.11, 0.85, 0.87])
legend('uplink comm',... 'Available for charging',...
     'downlink charge', 'downlink comm',...
    ...%'$\alpha = 2.5\%$, down', '$\alpha = 2.5\%$, up', ...
    ...% '$\alpha = 3.5\%$, down, ideal', '$\alpha = 3.5\%$, down, noisy', ...
    ...% '$\alpha = 3.5\%$, up, ideal', '$\alpha = 3.5\%$, up, noisy', ...
    ...% '$\alpha = 5.0\%$, down, ideal', '$\alpha = 5.0\%$, down, noisy', ...
    ...% '$\alpha = 5.0\%$, up, ideal', '$\alpha = 5.0\%$, up, noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'Southwest')

xlabel('Return Ratio $\alpha$ (\%)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Power ($\rm dBm$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)

% yyaxis right
% plot(Rs.*100, iter, 'LineStyle',':','Marker', 'd','MarkerSize',2,'LineWidth',2, 'color', [241 196 15]./255);


% xline(4, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(6, 'LineStyle',':','LineWidth',2, 'color', [241 196 15]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(7.5, 'LineStyle',':','LineWidth',2, 'color', [0 0.4470 0.7410] ...
%     ,'HandleVisibility','off'); % No need for legend