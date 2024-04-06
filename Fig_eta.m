%% eta vs Distance
clear all
% eta25down = [];
% eta25up = [];
% eta25down_n = [];
% eta25up_n = [];
eta35down = [];
eta35up = [];
eta35down_n = [];
eta35up_n = [];
eta50down = [];
eta50up = [];
eta50down_n = [];
eta50up_n = [];
eta80down = [];
eta80up = [];
eta80down_n = [];
eta80up_n = [];
R_x = 0;
% Ds25 = [1:0.2:3 3.25:0.25:4];
Ds35 = [1:0.2:3 3.25:0.25:4.25];
Ds50 = [1:0.2:3 3.25:0.25:4.25];
Ds80 = [1:0.2:3 3.25:0.25:4.25];

% for D = Ds25
%     filename = sprintf('./results/a25/dist%.1fshift%d.mat',D,R_x);
%     load(filename)
%     eta25down = [eta25down eta_down(end)];
%     eta25up = [eta25up eta_up(end)];
%     filename = sprintf('./results/a25/dist%.1fshift%d_noisy.mat',D,R_x);
%     load(filename)
%     eta_down = mean([eta_down1(end), eta_down2(end), eta_down3(end)]);
%     eta_up = mean([eta_up1(end), eta_up2(end), eta_up3(end)]);
%     eta25down_n = [eta25down_n eta_down];
%     eta25up_n = [eta25up_n eta_up];
% end
% eta25down(11) = 0.864; % Smooth out a misrecorded data point
% eta25down_n(14) = 0.825; % Smooth out a misrecorded data point
% eta25up_n(14) = 0.567; % Smooth out a misrecorded data point


for D = Ds35
    filename = sprintf('./results/28_32/a35/dist%.1fshift%.1f.mat',D,R_x);
    load(filename)
    eta35down = [eta35down eta_down1(end)];
    eta35up = [eta35up eta_up1(end)];
    filename = sprintf('./results/28_32/a35/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)
    eta_up1 =  eta_up1(find(~isnan(eta_up1)));
    eta_up2 =  eta_up2(find(~isnan(eta_up2)));
    eta_up3 =  eta_up3(find(~isnan(eta_up3)));
    eta_down1 =  eta_down1(find(~isnan(eta_down1)));
    eta_down2 =  eta_down2(find(~isnan(eta_down2)));
    eta_down3 =  eta_down3(find(~isnan(eta_down3)));
    eta_down = mean([eta_down1(end), eta_down2(end), eta_down3(end)]);
    eta_up = mean([eta_up1(end), eta_up2(end), eta_up3(end)]);
    eta35down_n = [eta35down_n eta_down];
    eta35up_n = [eta35up_n eta_up];
end
% eta35down_n(2) = 0.902; % Smooth out a misrecorded data point
% eta35up_n(2) = 0.847; % Smooth out a misrecorded data point

% for D = Ds50
%     filename = sprintf('./results/28_32/a50/dist%.1fshift%.1f.mat',D,R_x);
%     load(filename)
%     eta50down = [eta50down eta_down1(end)];
%     eta50up = [eta50up eta_up1(end)];
%     filename = sprintf('./results/28_32/a50/dist%.1fshift%.1f_noisy.mat',D,R_x);
%     load(filename)
%     eta_up1 =  eta_up1(find(~isnan(eta_up1)));
%     eta_up2 =  eta_up2(find(~isnan(eta_up2)));
%     eta_up3 =  eta_up3(find(~isnan(eta_up3)));
%     eta_down1 =  eta_down1(find(~isnan(eta_down1)));
%     eta_down2 =  eta_down2(find(~isnan(eta_down2)));
%     eta_down3 =  eta_down3(find(~isnan(eta_down3)));
%     eta_down = mean([eta_down1(end), eta_down2(end), eta_down3(end)]);
%     eta_up = mean([eta_up1(end), eta_up2(end), eta_up3(end)]);
%     eta50down_n = [eta50down_n eta_down];
%     eta50up_n = [eta50up_n eta_up];
% end
% 
% for D = Ds80
%     filename = sprintf('./results/28_32/a80/dist%.1fshift%.1f.mat',D,R_x);
%     load(filename)
%     eta80down = [eta80down eta_down1(end)];
%     eta80up = [eta80up eta_up1(end)];
%     filename = sprintf('./results/28_32/a80/dist%.1fshift%.1f_noisy.mat',D,R_x);
%     load(filename)
%     eta_up1 =  eta_up1(find(~isnan(eta_up1)));
%     eta_up2 =  eta_up2(find(~isnan(eta_up2)));
%     eta_up3 =  eta_up3(find(~isnan(eta_up3)));
%     eta_down1 =  eta_down1(find(~isnan(eta_down1)));
%     eta_down2 =  eta_down2(find(~isnan(eta_down2)));
%     eta_down3 =  eta_down3(find(~isnan(eta_down3)));
%     eta_down = mean([eta_down1(end), eta_down2(end), eta_down3(end)]);
%     eta_up = mean([eta_up1(end), eta_up2(end), eta_up3(end)]);
%     eta80down_n = [eta80down_n eta_down];
%     eta80up_n = [eta80up_n eta_up];
% end

clear plot
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 6.5 7 4])

% % plot(Ds25, eta25down, 'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
% plot(Ds25, eta25down_n, 'LineStyle','-','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);
% % plot(Ds25, eta25up, 'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
% plot(Ds25, eta25up_n, 'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);

plot(Ds35, eta35up, 'LineStyle',':','Marker', '^','MarkerSize',5,'LineWidth',2, 'color', [231 76 60]./255);
plot(Ds35, eta35up_n, 'LineStyle','-','Marker', '^','MarkerSize',5,'LineWidth',2, 'color', [231 76 60]./255);
plot(Ds35, eta35down, 'LineStyle',':','Marker', 'v','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);
plot(Ds35, eta35down_n, 'LineStyle','-','Marker', 'v','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);

% % plot(Ds50, eta50up, 'LineStyle',':','Marker', '^','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% plot(Ds50, eta50up_n, 'LineStyle','-','Marker', '^','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% % plot(Ds50, eta50down, 'LineStyle',':','Marker', 'v','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% plot(Ds50, eta50down_n, 'LineStyle','-','Marker', 'v','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% % 
% % plot(Ds80, eta80up, 'LineStyle',':','Marker', '^','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% plot(Ds80, eta80up_n, 'LineStyle','-','Marker', '^','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% % plot(Ds80, eta80down, 'LineStyle',':','Marker', 'v','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% plot(Ds80, eta80down_n, 'LineStyle','-','Marker', 'v','MarkerSize',5,'LineWidth',2, 'color', [0 0.4470 0.7410]);


% plot(Ds50, itr50, 'LineStyle',':','Marker', '*','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);
% plot(Ds50, itr50_n, 'LineStyle','-','Marker', '*','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);

axis on
box on
grid on
xlim([1 4]);
set(gca,'position',[0.089, 0.11, 0.899, 0.87])
legend('uplink, ideal', 'uplink, noisy', ...
    'downlink, ideal', 'downlink, noisy', ...
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
filename = sprintf('./results/28_32/a35/dist%.1fshift%.1f.mat',3,0);
load(filename)
eta_up = eta_up1;
eta_down = eta_down1;
itr = iterTimes1;
filename = sprintf('./results/28_32/a35/dist%.1fshift%.1f_noisy.mat',3,0);
load(filename)
maxLength = max([iterTimes1, iterTimes2, iterTimes3]);
eta_up1_padded = padarray(eta_up1, [0 maxLength-iterTimes1], NaN, 'post');
eta_up2_padded = padarray(eta_up2, [0 maxLength-iterTimes2], NaN, 'post');
eta_up3_padded = padarray(eta_up3, [0 maxLength-iterTimes3], NaN, 'post');
eta_up_n = mean([eta_up1_padded; eta_up2_padded; eta_up3_padded], 1, 'omitnan');
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

plot(eta_up, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255);
plot(eta_up_n, 'LineStyle','-','Marker', '^','MarkerSize',2,'LineWidth',2, 'color', [231 76 60]./255);

plot(eta_down, 'LineStyle',':','LineWidth',2, 'color', [0 0.4470 0.7410]);
plot(eta_down_n, 'LineStyle','-','Marker', 'v','MarkerSize',2,'LineWidth',2, 'color', [0 0.4470 0.7410]);

axis on
box on
grid on
xlim([0 itr]);
set(gca,'position',[0.089, 0.11, 0.899, 0.87])
legend('uplink, ideal', 'uplink, noisy', ...
    'downlink, ideal', 'downlink, noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'Best')

xlabel('Iterations','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Transmission Efficiency','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)

xline(itr-10, 'LineStyle',':','LineWidth',2, 'color', [241 196 15]./255 ...
    ,'HandleVisibility','off'); % No need for legend
