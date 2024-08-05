%% eta vs Distance
clear all

eta_RBS = [];
eta_RD = [];
% power_RBS = [];
% power_RBS_n = [];
% power_RD = [];
eta_RBS_n = [];
eta_RD_n = [];
R_x = 0;
Ds35 = [1:0.2:5];

for D = Ds35
    filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1f.mat',D,R_x);
    load(filename)
    eta_RBS = [eta_RBS eta_down1(end)];
    % power_RBS = [power_RBS Precv(end)];
    eta_RD = [eta_RD eta_down1(1)];
    % power_RD = [power_RD Precv(1)];
    filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)
    
    eta_down1 =  eta_down1(find(~isnan(eta_down1)));
    eta_down2 =  eta_down2(find(~isnan(eta_down2)));
    eta_down3 =  eta_down3(find(~isnan(eta_down3)));
    eta_down = mean([eta_down1(end), eta_down2(end), eta_down3(end)]);
    % PRBS_n = mean([PMr1(end), PMr2(end), PMr3(end)]) .* 0.996;
    % power_RBS_n = [power_RBS_n PRBS_n(end)];
    eta_Rd = mean([eta_down1(1), eta_down2(1), eta_down3(1)]);
    eta_RBS_n = [eta_RBS_n eta_down];
    eta_RD_n = [eta_RD_n eta_Rd];
end
% eta35down_n(2) = 0.902; % Smooth out a misrecorded data point
% eta35up_n(2) = 0.847; % Smooth out a misrecorded data point

clear plot
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 6.5 7 4])

plot(Ds35, eta_RD, 'LineStyle',':','Marker', '^','MarkerSize',5,'LineWidth',2, 'color', [231 76 60]./255);
%plot(Ds35, eta_RD_n, 'LineStyle','-','Marker', '^','MarkerSize',5,'LineWidth',2, 'color', [231 76 60]./255);
plot(Ds35, eta_RBS, 'LineStyle',':','Marker', 'v','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);
plot(Ds35, eta_RBS_n, 'LineStyle','-','Marker', 'v','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);

axis on
box on
grid on
xlim([1 5]);
ylim([0.6 1]);

set(gca,'position',[0.089, 0.11, 0.899, 0.87])
legend('Beamforming', ...
    'RBS, ideal', 'RBS, noisy', ...
    ...%'$\alpha = 2.5\%$, down', '$\alpha = 2.5\%$, up', ...
    ...% '$\alpha = 3.5\%$, down, ideal', '$\alpha = 3.5\%$, down, noisy', ...
    ...% '$\alpha = 3.5\%$, up, ideal', '$\alpha = 3.5\%$, up, noisy', ...
    ...% '$\alpha = 5.0\%$, down, ideal', '$\alpha = 5.0\%$, down, noisy', ...
    ...% '$\alpha = 5.0\%$, up, ideal', '$\alpha = 5.0\%$, up, noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'Southwest')

xlabel('Distance($\rm m$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Transmission Efficiency','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)

% xline(4, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(6, 'LineStyle',':','LineWidth',2, 'color', [241 196 15]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(7.5, 'LineStyle',':','LineWidth',2, 'color', [0 0.4470 0.7410] ...
%     ,'HandleVisibility','off'); % No need for legend
%% eta vs itr
clear all
filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1f.mat',3,0);
load(filename)
eta_up = eta_up1;
eta_down = eta_down1;
PMt = pow2db(PMt1) + 30;
PBt = pow2db(PBt1) + 30;
filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1fITR.mat',3,0);
load(filename)
itr = iterTimes1;
filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1f_noisy.mat',3,0);
load(filename)
maxLength = max([iterTimes1, iterTimes2, iterTimes3]);
eta_up1_padded = padarray(eta_up1, [0 maxLength-iterTimes1], NaN, 'post');
eta_up2_padded = padarray(eta_up2, [0 maxLength-iterTimes2], NaN, 'post');
eta_up3_padded = padarray(eta_up3, [0 maxLength-iterTimes3], NaN, 'post');
eta_up_n = mean([eta_up1_padded; eta_up2_padded; eta_up3_padded], 1, 'omitnan');

PBt1_padded = padarray(PBt1, [0 maxLength-iterTimes1], NaN, 'post');
PBt2_padded = padarray(PBt2, [0 maxLength-iterTimes2], NaN, 'post');
PBt3_padded = padarray(PBt3, [0 maxLength-iterTimes3], NaN, 'post');
PBt_n = mean([PBt1_padded; PBt2_padded; PBt3_padded], 1, 'omitnan');
PBt_n = pow2db(PBt_n) + 30;

PMt1_padded = padarray(PMt1, [0 maxLength-iterTimes1], NaN, 'post');
PMt2_padded = padarray(PMt2, [0 maxLength-iterTimes2], NaN, 'post');
PMt3_padded = padarray(PMt3, [0 maxLength-iterTimes3], NaN, 'post');
PMt_n = mean([PMt1_padded; PMt2_padded; PMt3_padded], 1, 'omitnan');
PMt_n = pow2db(PMt_n) + 30;

eta_down1_padded = padarray(eta_down1, [0 maxLength-iterTimes1], NaN, 'post');
eta_down2_padded = padarray(eta_down2, [0 maxLength-iterTimes2], NaN, 'post');
eta_down3_padded = padarray(eta_down3, [0 maxLength-iterTimes3], NaN, 'post');
eta_down_n = mean([eta_down1_padded; eta_down2_padded; eta_down3_padded], 1, 'omitnan');
% eta_up1 = eta_up1(1:min(itr,iterTimes1));
% eta_up2 = eta_up2(1:min(itr,iterTimes2));
% eta_up3 = eta_up3(1:min(itr,iterTimes3));
% eta_down1 = eta_down1(1:min(itr,iterTimes1));
% eta_down2 = eta_down2(1:min(itr,iterTimes2));
% eta_down3 = eta_down3(1:min(itr,iterTimes3));
% eta_up_n = (eta_up1 + eta_up2 + eta_up1) / 3;
% eta_down_n = (eta_down1 + eta_down2 + eta_down3) / 3;


clear plot
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 6.5 7 4])

yyaxis left
line_eu = plot(eta_up, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255);
line_eun = plot(eta_up_n, 'LineStyle','-','Marker', '^','MarkerSize',2,'LineWidth',2, 'color', [231 76 60]./255);

line_ed = plot(eta_down, 'LineStyle',':','LineWidth',2, 'color', [0 0.4470 0.7410]);
line_edn = plot(eta_down_n, 'LineStyle','-','Marker', 'v','MarkerSize',2,'LineWidth',2, 'color', [0 0.4470 0.7410]);

axis on
box on
grid on
xlim([0 itr]);
ylim([0.4 1]);
set(gca,'position',[0.085, 0.11, 0.82, 0.87])

xlabel('Iterations','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Transmission Efficiency','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)

yyaxis right

line_pu = plot(PMt, 'LineStyle',':','LineWidth',2, 'color', [244 139 129]./255);
line_pun = plot(PMt_n, 'LineStyle','-','Marker', '^','MarkerSize',2,'LineWidth',2, 'color', [244 139 129]./255);

line_pd = plot(PBt, 'LineStyle',':','LineWidth',2, 'color', [71 181 255]./255);
line_pdn = plot(PBt_n, 'LineStyle','-','Marker', 'v','MarkerSize',2,'LineWidth',2, 'color', [71 181 255]./255);

ylabel('Transmitted Power ($\mathrm{dBm}$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylim([-10 50]);

xline(itr-10, 'LineStyle',':','LineWidth',2, 'color', [241 196 15]./255 ...
    ,'HandleVisibility','off'); % No need for legend

annotation("arrow", [0.5 0.4], [0.88 0.88], 'LineWidth',1.5)
rectangle('Position',[26.4, 39, 3, 9],'Curvature',[0.5 0.5],'edgecolor','k','linewidth',1.5);
annotation("arrow", [0.62 0.72], [0.55 0.55], 'LineWidth',1.5)
rectangle('Position',[31, 10, 3, 30],'Curvature',[0.5 0.5],'edgecolor','k','linewidth',1.5);

ah=axes('position',get(gca,'position'), 'visible','off');
legend(ah,[line_eu, line_eun, line_ed, line_edn], ...
    'uplink, ideal', 'uplink, noisy', ...
    'downlink, ideal', 'downlink, noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'South')

%% power vs distance
clear all

power_down_t = [];
power_down_r = [];
power_up_t = [];
power_up_r = [];
power_charge = [];

R_x = 0;
Ds = [1:0.2:5];

for D = Ds

    filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)
    PBt = mean([PBt1 PBt2 PBt3]);
    PMr = mean([PMr1 PMr2 PMr3]);
    PBr = mean([PBr1 PBr2 PBr3]);
    PMt = mean([PMt1 PMt2 PMt3]);
    power_down_t = [power_down_t PBt];
    power_down_r = [power_down_r PMr];
    power_up_t = [power_up_t PMt];
    power_up_r = [power_up_r PBr];
end
power_charge = power_down_r *0.99;

clear plot
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 3.5 7 4])

plot(Ds, pow2db(power_up_t)+30, 'LineStyle',':','Marker', '^','MarkerSize',2,'LineWidth',2, 'color', [231 76 60]./255);
plot(Ds, pow2db(power_up_r)+30, 'LineStyle','-','Marker', '^','MarkerSize',2,'LineWidth',2, 'color', [231 76 60]./255);
%plot(Ds, pow2db(power_charge)+30, 'LineStyle',':','Marker', 'd','MarkerSize',2,'LineWidth',2, 'color', [241 196 15]./255);
plot(Ds, pow2db(power_down_t)+30, 'LineStyle',':','Marker', 'v','MarkerSize',2,'LineWidth',2, 'color', [0 0.4470 0.7410]);
plot(Ds, pow2db(power_down_r)+30, 'LineStyle','-','Marker', 'v','MarkerSize',2,'LineWidth',2, 'color', [0 0.4470 0.7410]);

axis on
box on
grid on
xlim([1 5]);


set(gca,'position',[0.089, 0.11, 0.899, 0.87])
legend('uplink Tx', 'uplink Rx', ...'Available for charging',...
     'downlink Tx', 'downlink Rx',...
    ...%'$\alpha = 2.5\%$, down', '$\alpha = 2.5\%$, up', ...
    ...% '$\alpha = 3.5\%$, down, ideal', '$\alpha = 3.5\%$, down, noisy', ...
    ...% '$\alpha = 3.5\%$, up, ideal', '$\alpha = 3.5\%$, up, noisy', ...
    ...% '$\alpha = 5.0\%$, down, ideal', '$\alpha = 5.0\%$, down, noisy', ...
    ...% '$\alpha = 5.0\%$, up, ideal', '$\alpha = 5.0\%$, up, noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'Southwest')

xlabel('Distance ($\rm m$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Power ($\rm dBm$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)

% xline(4, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(6, 'LineStyle',':','LineWidth',2, 'color', [241 196 15]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(7.5, 'LineStyle',':','LineWidth',2, 'color', [0 0.4470 0.7410] ...
%     ,'HandleVisibility','off'); % No need for legend