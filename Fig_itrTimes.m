%% Iterations vs Distance
% itr25 = [];
% itr25_n = [];
itr35 = [];
itr35_n = [];
itr50 = [];
itr50_n = [];
itr80 = [];
itr80_n = [];
R_x = 0;
Rs25 = [1:0.2:3 3.25:0.25:4];
Rs35 = [1:0.2:3 3.25:0.25:4.25];
Rs50 = [1:0.2:3 3.25:0.25:5 5.5:0.5:6.5];
Rs80 = [1:0.2:3 3.25:0.25:5 5.5:0.5:9];

% for D = Rs25
%     filename = sprintf('./results/28_32/a25/dist%.1fshift%d.mat',D,R_x);
%     load(filename)
%     itr25 = [itr25 iterTimes1];
%     filename = sprintf('./results/28_32/a25/dist%.1fshift%d.mat',D,R_x);
%     load(filename)
%     iterTimes = mean([iterTimes1, iterTimes2, iterTimes3]);
%     itr25_n = [itr25_n iterTimes];
% end
% itr25(11) = 58; % Smooth out a misrecorded data point

for D = Rs35
    filename = sprintf('./results/28_32/a35/dist%.1fshift%.1f.mat',D,R_x);
    load(filename)
    itr35 = [itr35 iterTimes1];
    filename = sprintf('./results/28_32/a35/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)
    iterTimes = mean([iterTimes1, iterTimes2, iterTimes3]);
    itr35_n = [itr35_n iterTimes];
end
% itr35_n(3) = 52; % Smooth out a misrecorded data point


for D = Rs50
    filename = sprintf('./results/28_32/a50/dist%.1fshift%.1f.mat',D,R_x);
    load(filename)
    itr50 = [itr50 iterTimes1];
    filename = sprintf('./results/28_32/a50/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)
    iterTimes = mean([iterTimes1, iterTimes2, iterTimes3]);
    itr50_n = [itr50_n iterTimes];
end

for D = Rs80
    filename = sprintf('./results/28_32/a80/dist%.1fshift%.1f.mat',D,R_x);
    load(filename)
    itr80 = [itr80 iterTimes1];
    filename = sprintf('./results/28_32/a80/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)
    iterTimes = mean([iterTimes1, iterTimes2, iterTimes3]);
    itr80_n = [itr80_n iterTimes];
end

clear plot
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 6.5 7 4])

% plot(Rs25, itr25-10, 'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
% plot(Rs25, itr25_n-10, 'LineStyle','-','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);

plot(Rs35, itr35-10, 'LineStyle',':','Marker', 'd','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
plot(Rs35, itr35_n-10, 'LineStyle','-','Marker', 'd','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);

plot(Rs50, itr50-10, 'LineStyle',':','Marker', '*','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);
plot(Rs50, itr50_n-10, 'LineStyle','-','Marker', '*','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);

plot(Rs80, itr80-10, 'LineStyle',':','Marker', 'd','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);
plot(Rs80, itr80_n-10, 'LineStyle','-','Marker', 'd','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);

%stable_cnt == 0 -> iter == iterRequired + 10

axis on
box on
grid on
xlim([1 9.5]);
%ylim([10 140])
set(gca,'position',[0.085, 0.11, 0.905, 0.87])
legend(...%'$\alpha = 2.5\%$, ideal', '$\alpha = 2.5\%$, noisy', ...
    '$\alpha = 3.5\%$, ideal', '$\alpha = 3.5\%$, noisy', ...
    '$\alpha = 5.0\%$, ideal', '$\alpha = 5.0\%$, noisy', ...
    '$\alpha = 8.0\%$, ideal', '$\alpha = 8.0\%$, noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'Best')

xlabel('Distance($\rm m$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Iterations','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)

% xline(4, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
xline(4.25, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255 ...
    ,'HandleVisibility','off'); % No need for legend
xline(6.5, 'LineStyle',':','LineWidth',2, 'color', [241 196 15]./255 ...
    ,'HandleVisibility','off'); % No need for legend
xline(9, 'LineStyle',':','LineWidth',2, 'color', [0 0.4470 0.7410] ...
    ,'HandleVisibility','off'); % No need for legend
%% Iterations vs Shift
% itr25 = [];
% itr25_n = [];
itr35 = [];
itr35_n = [];
itr50 = [];
itr50_n = [];
itr80 = [];
itr80_n = [];
D = 3;
% Rs25 = [-1.5:0.1:1.5];
Rs35 = [-1.5:0.1:1.5];
Rs50 = [-1.5:0.1:1.5];
Rs80 = [-1.5:0.1:1.5];
% 
% for R_x = Rs25
%     filename = sprintf('./results/a25/dist%.1fshift%.1f.mat',D,R_x);
%     load(filename)
%     itr25 = [itr25 iterTimes1];
%     filename = sprintf('./results/a25/dist%.1fshift%.1f_noisy.mat',D,R_x);
%     load(filename)
%     iterTimes = mean([iterTimes1, iterTimes2, iterTimes3]);
%     itr25_n = [itr25_n iterTimes1];
% end
% itr25_n(3) = 126;
% itr25(16) = 58; % Smooth out a misrecorded data point

for R_x = Rs35
    filename = sprintf('./results/28_32/a35/dist%.1fshift%.1f.mat',D,R_x);
    load(filename)
    itr35 = [itr35 iterTimes1];
    filename = sprintf('./results/28_32/a35/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)
    iterTimes = mean([iterTimes1, iterTimes2, iterTimes3]);
    itr35_n = [itr35_n iterTimes];
end

for R_x = Rs50
    filename = sprintf('./results/28_32/a50/dist%.1fshift%.1f.mat',D,R_x);
    load(filename)
    itr50 = [itr50 iterTimes1];
    filename = sprintf('./results/28_32/a50/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)
    iterTimes = mean([iterTimes1, iterTimes2, iterTimes3]);
    itr50_n = [itr50_n iterTimes1];
end
% itr50_n(14) = 52;
% itr50_n(16) = 43;
% itr50_n(19) = 57;
% itr50_n(20) = 48;
for R_x = Rs80
    filename = sprintf('./results/28_32/a80/dist%.1fshift%.1f.mat',D,R_x);
    load(filename)
    itr80 = [itr80 iterTimes1];
    filename = sprintf('./results/28_32/a80/dist%.1fshift%.1f_noisy.mat',D,R_x);
    load(filename)
    iterTimes = mean([iterTimes1, iterTimes2, iterTimes3]);
    itr80_n = [itr80_n iterTimes1];
end

clear plot
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 6.5 7 4])

% plot(Rs25, itr25-10, 'LineStyle',':','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);
% plot(Rs25, itr25_n-10, 'LineStyle','-','Marker', 'v','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);

plot(Rs35, itr35-10, 'LineStyle',':','Marker', 'd','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);
plot(Rs35, itr35_n-10, 'LineStyle','-','Marker', 'd','MarkerSize',4,'LineWidth',2, 'color', [231 76 60]./255);

plot(Rs50, itr50-10, 'LineStyle',':','Marker', '*','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);
plot(Rs50, itr50_n-10, 'LineStyle','-','Marker', '*','MarkerSize',4,'LineWidth',2, 'color', [241 196 15]./255);

plot(Rs80, itr80-10, 'LineStyle',':','Marker', '*','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);
plot(Rs80, itr80_n-10, 'LineStyle','-','Marker', '*','MarkerSize',4,'LineWidth',2, 'color', [0 0.4470 0.7410]);

ylim([0 90])

axis on
box on
grid on
xlim([-1.5 1.5]);
set(gca,'position',[0.085, 0.11, 0.90, 0.87])
% legend(...%'$\alpha = 2.5\%$, ideal', '$\alpha = 2.5\%$, noisy', ...
%     '$\alpha = 3.5\%$, ideal', '$\alpha = 3.5\%$, noisy', ...
%     '$\alpha = 5.0\%$, ideal', '$\alpha = 5.0\%$, noisy', ...
%     '$\alpha = 8.0\%$, ideal', '$\alpha = 8.0\%$, noisy', ...
%     'interpreter', 'latex', 'FontName', 'Times New Roman', ...
%     'FontSize', 16, 'Location', 'North')

xlabel('Shift($\rm m$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Iterations','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)

% xline(4, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(6, 'LineStyle',':','LineWidth',2, 'color', [241 196 15]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(7.5, 'LineStyle',':','LineWidth',2, 'color', [0 0.4470 0.7410] ...
%     ,'HandleVisibility','off'); % No need for legend
