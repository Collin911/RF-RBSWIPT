%% Iterations vs Distancefigure

itrT = [];
time = [];
itrT_n = [];
time_n = [];
angle = 0;
Ds = 1:0.2:5;

for D = Ds
    filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1fITR.mat',D,angle);
    load(filename)
    %i = ceil(sqrt((iterTimes1 -10) * 0.5)*5);
    i = iterTimes1 -10;
    t = i*D/3e8*1e6; % us
    itrT = [itrT i];
    time = [time t];
    filename = sprintf('./results/50x50_single_HMC1132_/dist%.1fshift%.1f_noisy.mat',D,angle);
    load(filename)
    i1 = (iterTimes1 -10);
    i2 = (iterTimes2 -10);
    i3 = (iterTimes3 -10);
    i = mean([i1, i2, i3])+10;
    t = i*D/3e8*1e6;
    itrT_n = [itrT_n i];
    time_n = [time_n t];
end



clear plot
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 6.5 7 4])

yyaxis left
Pitr = plot(Ds, itrT, 'LineStyle',':','Marker', 'd','MarkerSize',4,'LineWidth',2);%, 'color', [231 76 60]./255);
Pitr_n = plot(Ds, itrT_n, 'LineStyle','-','Marker', 'd','MarkerSize',4,'LineWidth',2);%, 'color', [231 76 60]./255);

%stable_cnt == 0 -> iter == iterRequired + 10

axis on
box on
grid on
xlim([1 5]);
%ylim([10 140])
set(gca,'position',[0.085, 0.11, 0.82, 0.87])
xlabel('Distance($\rm m$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Iterations','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)


yyaxis right
Pt = plot(Ds, time, 'LineStyle',':','Marker', 'd','MarkerSize',4,'LineWidth',2);%, 'color', [231 76 60]./255);
Pt_n = plot(Ds, time_n, 'LineStyle','-','Marker', 'd','MarkerSize',4,'LineWidth',2);%, 'color', [231 76 60]./255);
ylabel('Time ($\mu$s)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)

annotation("arrow",[0.29 0.22], [0.79 0.79]);
annotation("arrow",[0.79 0.86], [0.85 0.85]);

ah=axes('position',get(gca,'position'), 'visible','off');
legend(ah,[Pitr, Pitr_n], 'Ideal', 'Noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'Northwest')

ah=axes('position',get(gca,'position'), 'visible','off');
legend(ah,[Pt, Pt_n], 'Ideal', 'Noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'Northeast')




% xline(4, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(4.25, 'LineStyle',':','LineWidth',2, 'color', [231 76 60]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(6.5, 'LineStyle',':','LineWidth',2, 'color', [241 196 15]./255 ...
%     ,'HandleVisibility','off'); % No need for legend
% xline(9, 'LineStyle',':','LineWidth',2, 'color', [0 0.4470 0.7410] ...
%     ,'HandleVisibility','off'); % No need for legend
%% Iterations vs Shift

itrT = [];
time = [];
itrT_n = [];
time_n = [];
D = 3;

shift_angles = 0:10:50;


for angle = shift_angles./180.*pi
    filename = sprintf('./results/50x50_single_HMC1132/dist%.1fshift%.1f.mat',D,angle);
    load(filename)
    i = ceil(sqrt((iterTimes1 -10) * 0.5)*5);
    t = i*D/3e8*1e6; % us
    itrT = [itrT i];
    time = [time t];
    filename = sprintf('./results/50x50_single_HMC1132/dist%.1fshift%.1f_noisy.mat',D,angle);
    load(filename)
    i1 = (iterTimes1 -10);
    i2 = (iterTimes2 -10);
    i3 = (iterTimes3 -10);
    i = mean([i1, i2, i3]);
    t = i*D/3e8*1e6;
    itrT_n = [itrT_n i];
    time_n = [time_n t];
end



clear plo  t
figure
hold on
set(gcf, 'unit', 'inch', 'position', [3 6.5 7 4])

yyaxis left
Pitr = plot(shift_angles, itrT, 'LineStyle',':','Marker', 'd','MarkerSize',4,'LineWidth',2);%, 'color', [231 76 60]./255);
Pitr_n = plot(shift_angles, itrT_n, 'LineStyle','-','Marker', 'd','MarkerSize',4,'LineWidth',2);%, 'color', [231 76 60]./255);

%stable_cnt == 0 -> iter == iterRequired + 10

axis on
box on
grid on
% xlim([1 5]);
% ylim([10 140])
set(gca,'position',[0.085, 0.11, 0.82, 0.87])
xlabel('Distance($\rm m$)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)
ylabel('Iterations','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)


yyaxis right
Pt = plot(shift_angles, time, 'LineStyle',':','Marker', 'd','MarkerSize',4,'LineWidth',2);%, 'color', [231 76 60]./255);
Pt_n = plot(shift_angles, time_n, 'LineStyle','-','Marker', 'd','MarkerSize',4,'LineWidth',2);%, 'color', [231 76 60]./255);
ylabel('Time ($\mu$s)','interpreter', 'latex', 'FontName', 'Times New Roman', 'FontSize', 16)

annotation("arrow",[0.27 0.20], [0.73 0.73]);
annotation("arrow",[0.80 0.87], [0.73 0.73]);

ah=axes('position',get(gca,'position'), 'visible','off');
legend(ah,[Pitr, Pitr_n], 'Ideal', 'Noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'Northwest')

ah=axes('position',get(gca,'position'), 'visible','off');
legend(ah,[Pt, Pt_n], 'Ideal', 'Noisy', ...
    'interpreter', 'latex', 'FontName', 'Times New Roman', ...
    'FontSize', 16, 'Location', 'Northeast')
